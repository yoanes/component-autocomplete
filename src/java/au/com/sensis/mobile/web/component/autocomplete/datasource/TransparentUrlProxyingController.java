package au.com.sensis.mobile.web.component.autocomplete.datasource;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.IOUtils;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.AbstractController;

import au.com.sensis.wireless.common.utils.http.HttpClientService;
import au.com.sensis.wireless.common.utils.http.HttpResponse;

/**
 * Controller that transparently proxies a URL.
 *
 * @author Adrian.Koh2@sensis.com.au
 */
public class TransparentUrlProxyingController extends AbstractController {

    private static final String URL_PARAM_NAME = "url";
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
    protected ModelAndView handleRequestInternal(final HttpServletRequest httpServletRequest,
            final HttpServletResponse httpServletResponse) throws Exception {

        try {
            final String urlToProxy = httpServletRequest.getParameter(URL_PARAM_NAME);
            final HttpResponse httpResponse = getHttpClientService().get(urlToProxy);

            IOUtils.copy(httpResponse.getResponseBodyAsReader(), httpServletResponse.getWriter());
        } catch (final Exception e) {
            httpServletResponse.setStatus(HttpServletResponse.SC_NOT_FOUND);
        }

        return null;
    }

    /**
     * @return the httpClientService
     */
    private HttpClientService getHttpClientService() {
        return httpClientService;
    }

}
