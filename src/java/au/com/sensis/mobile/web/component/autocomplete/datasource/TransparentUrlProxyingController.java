package au.com.sensis.mobile.web.component.autocomplete.datasource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import au.com.sensis.wireless.common.utils.http.HttpClientService;
import au.com.sensis.wireless.common.utils.http.HttpResponse;

/**
 * Controller that transparently proxies a URL, except that HTTP headers from
 * the orignal request are ignored and only get requests are supported.
 * <p>
 * You may choose to extend this class and override the
 * {@link #writeActualResponse(HttpResponse, HttpServletResponse)} if you wish
 * to modify the response before it is returned.
 * </p>
 *
 * @author Adrian.Koh2@sensis.com.au
 */
public class TransparentUrlProxyingController extends AbstractController {

    protected static final String URL_PARAM_NAME = "url";
    private final HttpClientService httpClientService;

    /**
     * Default Constructor.
     *
     * @param httpClientService
     *            {@link HttpClientService} to use for sending http requests.
     */
    public TransparentUrlProxyingController(
            final HttpClientService httpClientService) {
        super();
        this.httpClientService = httpClientService;
    }

    /**
     * {@inheritDoc}
     */
    @Override
    protected ModelAndView handleRequestInternal(
            final HttpServletRequest httpServletRequest,
            final HttpServletResponse httpServletResponse) throws Exception {

        try {
            final String urlToProxy =
                    httpServletRequest.getParameter(URL_PARAM_NAME);
            final HttpResponse urlToProxyHttpResponse =
                    getHttpClientService().get(urlToProxy);

            writeActualResponse(httpServletRequest, urlToProxyHttpResponse, httpServletResponse);
        } catch (final Exception e) {
            httpServletResponse.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }

        return null;
    }

    /**
     * @param httpServletRequest  {@link HttpServletRequest} that was requested.
     * @param urlToProxyHttpResponse
     *            Response from the URL that was proxied.
     * @param httpServletResponse
     *            Response that this proxy controller will return.
     * @throws Exception
     *             Thrown if any error occurs.
     */
    protected void writeActualResponse(
            final HttpServletRequest httpServletRequest, final HttpResponse urlToProxyHttpResponse,
            final HttpServletResponse httpServletResponse) throws Exception {
        IOUtils.copy(urlToProxyHttpResponse.getResponseBodyAsReader(),
                httpServletResponse.getWriter());
    }

    /**
     * @return the httpClientService
     */
    protected HttpClientService getHttpClientService() {
        return httpClientService;
    }

}
