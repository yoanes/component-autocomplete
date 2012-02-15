package au.com.sensis.mobile.web.component.autocomplete.datasource;

import java.io.ByteArrayOutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.web.servlet.ModelAndView;

import au.com.sensis.wireless.common.utils.http.HttpClientService;
import au.com.sensis.wireless.common.utils.http.HttpResponse;

public class Location2UrlProxyingController extends TransparentUrlProxyingController {

    class RequestPayload {
	
	public String query;
	public String maxSize;
	public ArrayList<String> granularity = new ArrayList<String>();
	
	RequestPayload(String query, String limit) {
	    this.query = query;
	    this.maxSize = limit;
	    
	    this.granularity.add("STATE");
	    this.granularity.add("REGION");
	    this.granularity.add("SUBURB");
	}
	
    }
    
    private static final String QUERY_PARAM_NAME = "?query=";
    private static final String LIMIT_PARAM_NAME = "limit";
    
    private String token;
    private String password;
    
    private final ObjectMapper jacksonMapper = new ObjectMapper();
    
    public Location2UrlProxyingController(HttpClientService httpClientService) {
	super(httpClientService);
	// TODO Auto-generated constructor stub
    }
    
    @Override
    protected ModelAndView handleRequestInternal(
            final HttpServletRequest httpServletRequest,
            final HttpServletResponse httpServletResponse) throws Exception {

        try {
            /* first we need to split the url and the query
             * the other proxies pass the query along with url but not the case with ems2
             * the js however is built for the other proxies meaning we need to do extra
             * string tokenizing here
             */
            final String baseUrl =
                    httpServletRequest.getParameter(URL_PARAM_NAME);
            
            int i = baseUrl.indexOf("?");
            final String urlToProxy = baseUrl.substring(0, i);
           
            /* generate the additional header */
            final HashMap<String, String> header  = new HashMap<String, String>();
            header.put("X-Auth-Token", getToken());
            header.put("X-Auth-Password", getPassword());
            
            /* set the content type */
            final String contentType = "application/json";
            
            /* generate the payload that will be transformed into json */
            final RequestPayload data = new RequestPayload(
        	    baseUrl.substring(i + QUERY_PARAM_NAME.length()),
        	    httpServletRequest.getParameter(LIMIT_PARAM_NAME));
           
            ByteArrayOutputStream os = new ByteArrayOutputStream();
            jacksonMapper.writeValue(os, data);

            /* post it */
            final HttpResponse urlToProxyHttpResponse =
                    getHttpClientService().post(urlToProxy, os.toString(), contentType, null, header);

            /* return the json as it is */
            writeActualResponse(httpServletRequest, urlToProxyHttpResponse, httpServletResponse);
        } catch (final Exception e) {
            e.printStackTrace();
            httpServletResponse.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }

        return null;
    }

    /**
     * @return the token
     */
    public String getToken() {
        return token;
    }

    /**
     * @param token the token to set
     */
    public void setToken(String token) {
        this.token = token;
    }

    /**
     * @return the password
     */
    public String getPassword() {
        return password;
    }

    /**
     * @param password the password to set
     */
    public void setPassword(String password) {
        this.password = password;
    }
}