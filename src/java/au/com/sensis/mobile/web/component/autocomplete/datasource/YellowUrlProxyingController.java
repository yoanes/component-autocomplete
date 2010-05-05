package au.com.sensis.mobile.web.component.autocomplete.datasource;

import java.io.Reader;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.DeserializationConfig.Feature;

import au.com.sensis.wireless.common.utils.http.HttpClientService;
import au.com.sensis.wireless.common.utils.http.HttpResponse;

/**
 * Controller that proxies the yellow JSON search suggestions end point to allow
 * the caller to specify a limit on the number of results returned (via the
 * {@link #LIMIT_PARAM_NAME} request param).
 *
 * @author Adrian.Koh2@sensis.com.au
 */
public class YellowUrlProxyingController extends
        TransparentUrlProxyingController {

    private static final String LIMIT_PARAM_NAME = "limit";

    private final ObjectMapper jacksonMapper = new ObjectMapper();

    /**
     * Default Constructor.
     *
     * @param httpClientService
     *            {@link HttpClientService} to use for sending http requests.
     */
    public YellowUrlProxyingController(final HttpClientService httpClientService) {
        super(httpClientService);

        final DeserializationConfig deserializationConfig =
                jacksonMapper.getDeserializationConfig();
        deserializationConfig.set(Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);

    }

    /**
     * {@inheritDoc}
     */
    @Override
    protected void writeActualResponse(
            final HttpServletRequest httpServletRequest,
            final HttpResponse urlToProxyHttpResponse,
            final HttpServletResponse httpServletResponse) throws Exception {

        final int suggestionsLimit =
                Integer.parseInt(httpServletRequest
                        .getParameter(LIMIT_PARAM_NAME));

        final Reader reader = urlToProxyHttpResponse.getResponseBodyAsReader();
        final YellowSearchSuggestions yellowSearchSuggestions =
                jacksonMapper.readValue(reader, YellowSearchSuggestions.class);

        final List<String> limitedSuggestions =
                limitSuggestions(suggestionsLimit, yellowSearchSuggestions);
        final List<String> limitedData =
                limitData(suggestionsLimit, yellowSearchSuggestions);

        final YellowSearchSuggestions limitedYellowSearchSuggestions =
                new YellowSearchSuggestions(yellowSearchSuggestions.getQuery(),
                        limitedSuggestions, limitedData);

        jacksonMapper.writeValue(httpServletResponse.getWriter(),
                limitedYellowSearchSuggestions);
    }

    /**
     * @param suggestionsLimit
     * @param yellowSearchSuggestions
     * @return
     */
    private List<String> limitData(final int suggestionsLimit,
            final YellowSearchSuggestions yellowSearchSuggestions) {
        List<String> limitedData = null;
        if (yellowSearchSuggestions.getData().size() < suggestionsLimit) {
            limitedData = yellowSearchSuggestions.getData();
        } else {
            limitedData =
                    yellowSearchSuggestions.getData().subList(0,
                            suggestionsLimit);
        }
        return limitedData;
    }

    /**
     * @param suggestionsLimit
     * @param yellowSearchSuggestions
     * @return
     */
    private List<String> limitSuggestions(final int suggestionsLimit,
            final YellowSearchSuggestions yellowSearchSuggestions) {
        List<String> limitedSuggestions = null;
        if (yellowSearchSuggestions.getSuggestions().size() < suggestionsLimit) {
            limitedSuggestions = yellowSearchSuggestions.getSuggestions();
        } else {
            limitedSuggestions =
                    yellowSearchSuggestions.getSuggestions().subList(0,
                            suggestionsLimit);
        }
        return limitedSuggestions;
    }

}
