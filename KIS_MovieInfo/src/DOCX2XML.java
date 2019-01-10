import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import org.docx4j.Docx4J;
import org.docx4j.openpackaging.exceptions.Docx4JException;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.openpackaging.parts.WordprocessingML.MainDocumentPart;

@WebServlet(urlPatterns="/DOCX2XML")
@MultipartConfig(fileSizeThreshold=1024*1024*15, // 15MB
maxFileSize=1024*1024*50,      // 50MB
maxRequestSize=1024*1024*100)   // 100MB
public class DOCX2XML extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String SAVE_DIR = "uploadFiles";
	
    public DOCX2XML() {
    }
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response)  throws ServletException, IOException {
		try {
	        String appPath = request.getServletContext().getRealPath("");
	        String savePath = appPath + File.separator + SAVE_DIR;
	        
	        File fileSaveDir = new File(savePath);
	        if (!fileSaveDir.exists())
	            fileSaveDir.mkdir();
	         
	        String fileName = "";
	        for (Part part : request.getParts()) {
	            fileName = extractFileName(part);
	            fileName = new File(fileName).getName();
	            part.write(savePath + File.separator + fileName);
	        }
	        
	        String potDoDatoteke = savePath + File.separator + fileName;
	        if(potDoDatoteke.endsWith(".docx")) {
	        	response.setContentType("application/xml");
	    		response.setCharacterEncoding("UTF-8");
	        	PrintWriter out = response.getWriter();
		        WordprocessingMLPackage wordMLPackage = new WordprocessingMLPackage();
				wordMLPackage = Docx4J.load(new java.io.File(savePath + File.separator + fileName));
				MainDocumentPart documentPart = wordMLPackage.getMainDocumentPart();
				out.write(documentPart.getXML());
				out.flush();
	        } else {
	    		response.setContentType("text/html");
	    		response.setCharacterEncoding("UTF-8");
	        	PrintWriter out = response.getWriter();
	        	out.println("<script type=\"text/javascript\">");
	        	out.println("alert('Sprejemamo le .docx datoteke!');");
	        	out.println("location='index.html';");
	        	out.println("</script>");
	        }
		} catch (Docx4JException e) {
    		response.setContentType("text/html");
    		response.setCharacterEncoding("UTF-8");
        	PrintWriter out = response.getWriter();
        	out.println("<script type=\"text/javascript\">");
        	out.println("alert('Sprejemamo le .docx datoteke!');");
        	out.println("location='index.html';");
        	out.println("</script>");
		}
    }
    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename"))
                return s.substring(s.indexOf("=") + 2, s.length()-1);
        }
        return "";
    }
}