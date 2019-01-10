import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerConfigurationException;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;

import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopConfParser;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.FopFactoryBuilder;
import org.apache.xmlgraphics.util.MimeConstants;
import org.docx4j.Docx4J;
import org.docx4j.openpackaging.exceptions.Docx4JException;
import org.docx4j.openpackaging.packages.WordprocessingMLPackage;
import org.docx4j.openpackaging.parts.WordprocessingML.MainDocumentPart;
import org.xml.sax.SAXException;

import net.sf.saxon.TransformerFactoryImpl;

@WebServlet(urlPatterns="/DOCX2PDF")
@MultipartConfig(fileSizeThreshold=1024*1024*15, // 15MB
maxFileSize=1024*1024*50,      // 50MB
maxRequestSize=1024*1024*100)   // 100MB
public class DOCX2PDF extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private static final String SAVE_DIR = "uploadFiles";
	
    public DOCX2PDF() {
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
	        	response.setContentType("application/pdf");
	    		response.setCharacterEncoding("UTF-8");
	    		
	    		ByteArrayOutputStream out = new ByteArrayOutputStream();
	    		
				File xconf = new File(getServletContext().getRealPath("XML/fop.xconf"));
				FopConfParser parser = new FopConfParser(xconf);
				FopFactoryBuilder builder = parser.getFopFactoryBuilder();
				FopFactory fopFactory = builder.build();
	    		
				Source xsltSrc = new StreamSource("http://localhost:8080/KIS_MovieInfo/XML/TransformacijaDOCX2PDF.xsl");
				TransformerFactory transFact = new TransformerFactoryImpl();
				Transformer transformer = transFact.newTransformer(xsltSrc);
				
				Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, out);
				Result res = new SAXResult(fop.getDefaultHandler());
				
				WordprocessingMLPackage wordMLPackage = new WordprocessingMLPackage();
				wordMLPackage = Docx4J.load(new java.io.File(savePath + File.separator + fileName));
				MainDocumentPart documentPart = wordMLPackage.getMainDocumentPart();
				
				File xmlFile = new File(savePath + File.separator + "uploadanXML.xml");
				FileWriter fw = new FileWriter(xmlFile);
				fw.write(documentPart.getXML());
				fw.flush();
				fw.close();
				
				Source src = new StreamSource(savePath + File.separator + "uploadanXML.xml");
				transformer.transform(src, res);
				
				response.setContentLength(out.size());
				response.getOutputStream().write(out.toByteArray());
				response.getOutputStream().flush();
	        } else {
	        	PrintWriter out = response.getWriter();
	    		response.setContentType("text/html");
	    		response.setCharacterEncoding("UTF-8");
	        	out.println("<script type=\"text/javascript\">");
	        	out.println("alert('Sprejemamo le .docx datoteke!');");
	        	out.println("location='index.html';");
	        	out.println("</script>");
	        }
		} catch (Docx4JException e) {
        	PrintWriter out = response.getWriter();
    		response.setContentType("text/html");
    		response.setCharacterEncoding("UTF-8");
        	out.println("<script type=\"text/javascript\">");
        	out.println("alert('Sprejemamo le .docx datoteke!');");
        	out.println("location='index.html';");
        	out.println("</script>");
		} catch (SAXException e) {
			e.printStackTrace();
		} catch (TransformerConfigurationException e) {
			e.printStackTrace();
		} catch (TransformerException e) {
			e.printStackTrace();
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