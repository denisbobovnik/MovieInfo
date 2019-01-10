import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerException;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.stream.StreamResult;
import javax.xml.transform.stream.StreamSource;

import net.sf.saxon.TransformerFactoryImpl;

@WebServlet(urlPatterns="/AktualnoServlet")
public class AktualnoServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public AktualnoServlet() {
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/xml");
		response.setCharacterEncoding("UTF-8");
		PrintWriter out = response.getWriter();
		try {
			String xmlFile = "http://localhost:8080/KIS_MovieInfo/XML/MovieList.xml";
			StreamSource xmlSource = new StreamSource(xmlFile);
			
			String xsltFile = "http://localhost:8080/KIS_MovieInfo/XML/TransformacijaXML.xsl"; 
			StreamSource xsltSource = new StreamSource(xsltFile);
			
			StreamResult xmlRET = new StreamResult(out); 
			
			TransformerFactory transFact = new TransformerFactoryImpl();
			Transformer trans = transFact.newTransformer(xsltSource);
			trans.transform(xmlSource, xmlRET);
		} catch (TransformerException e) {
			e.printStackTrace();
		}
	}
}