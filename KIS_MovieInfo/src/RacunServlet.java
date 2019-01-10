import java.io.File;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.transform.Result;
import javax.xml.transform.Source;
import javax.xml.transform.Transformer;
import javax.xml.transform.TransformerFactory;
import javax.xml.transform.sax.SAXResult;
import javax.xml.transform.stream.StreamSource;
import org.apache.fop.apps.Fop;
import org.apache.fop.apps.FopConfParser;
import org.apache.fop.apps.FopFactory;
import org.apache.fop.apps.FopFactoryBuilder;
import org.apache.xmlgraphics.util.MimeConstants;

@WebServlet(urlPatterns="/RacunServlet")
public class RacunServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public RacunServlet() {
    }
    
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/pdf");
		response.setCharacterEncoding("UTF-8");
		try {
			File xconf = new File(getServletContext().getRealPath("XML/fop.xconf"));
			FopConfParser parser = new FopConfParser(xconf);
			FopFactoryBuilder builder = parser.getFopFactoryBuilder();
			FopFactory fopFactory = builder.build();
			
			Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, response.getOutputStream());
			TransformerFactory tFactory = TransformerFactory.newInstance();
			Transformer transformer = tFactory.newTransformer();
						
			Source src = new StreamSource("http://localhost:8080/KIS_MovieInfo/XML/RacunVstopnice.fo");
			Result res = new SAXResult(fop.getDefaultHandler());
			
			transformer.transform(src, res);
			
			response.getOutputStream().flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}