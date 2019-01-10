import java.io.ByteArrayOutputStream;
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
import net.sf.saxon.TransformerFactoryImpl;

@WebServlet(urlPatterns="/PredstavePDFServlet")
public class PredstavePDFServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
    public PredstavePDFServlet() {
    }

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("application/pdf");
		response.setCharacterEncoding("UTF-8");
		String center = request.getParameter("center");
		try {
			ByteArrayOutputStream out = new ByteArrayOutputStream();
			
			File xconf = new File(getServletContext().getRealPath("XML/fop.xconf"));
			FopConfParser parser = new FopConfParser(xconf);
			FopFactoryBuilder builder = parser.getFopFactoryBuilder();
			FopFactory fopFactory = builder.build();
			
			Source xsltSrc = new StreamSource("http://localhost:8080/KIS_MovieInfo/XML/TransformacijaPredstavePDF.xsl");
			TransformerFactory transFact = new TransformerFactoryImpl();
			Transformer transformer = transFact.newTransformer(xsltSrc);
			
			Fop fop = fopFactory.newFop(MimeConstants.MIME_PDF, out);
			Result res = new SAXResult(fop.getDefaultHandler());
			Source src = new StreamSource("http://localhost:8080/KIS_MovieInfo/XML/ShowtimeList.xml");
			
			transformer.setParameter("center", center);
			transformer.transform(src, res);
			
			response.setContentLength(out.size());
			response.getOutputStream().write(out.toByteArray());
			response.getOutputStream().flush();
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}