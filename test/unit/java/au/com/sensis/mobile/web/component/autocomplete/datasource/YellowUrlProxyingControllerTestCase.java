package au.com.sensis.mobile.web.component.autocomplete.datasource;

import java.io.StringReader;

import org.codehaus.jackson.map.DeserializationConfig;
import org.codehaus.jackson.map.ObjectMapper;
import org.codehaus.jackson.map.DeserializationConfig.Feature;
import org.easymock.EasyMock;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;

import au.com.sensis.wireless.common.utils.http.HttpClientService;
import au.com.sensis.wireless.common.utils.http.HttpResponse;
import au.com.sensis.wireless.test.AbstractJUnit4TestCase;

/**
 * Unit test {@link YellowUrlProxyingController}.
 *
 * @author Adrian.Koh2@sensis.com.au
 *
 */
public class YellowUrlProxyingControllerTestCase extends AbstractJUnit4TestCase {

    private static final String LIMIT_PARAM = "7";

    private static final String NO_SUGGESTIONS_FOUND_RESPONSE =
            "{ \"query\": \"aoinhst\", \"suggestions\": [ ], \"data\": [ ] }";

    private static final String SUGGESTIONS_FOUND_EQUALS_LIMIT_RESPONSE =
            "{ \"query\": \"locks\", "
                    + "\"suggestions\": [ \"locksmiths\", \"locks\", \"locks & locksmiths\", "
                    + "\"locks & locksmiths automotive\", "
                    + "\"locks & locksmiths key cutting\", \"locks & locksmiths duplicate keys\", "
                    + "\"locksmiths' supplies\" ], "
                    + "\"data\": [ \"type\", \"type\", \"type\", \"type\", \"type\", "
                    + "\"type\", \"type\" ] }";

    private static final String SUGGESTIONS_FOUND_LESS_THAN_LIMIT_RESPONSE =
            "{ \"query\": \"locks\", "
                    + "\"suggestions\": [ \"locksmiths\", \"locks\", \"locks & locksmiths\", "
                    + "\"locks & locksmiths automotive\", "
                    + "\"locks & locksmiths key cutting\", "
                    + "\"locks & locksmiths duplicate keys\" ], "
                    + "\"data\": [ \"type\", \"type\", \"type\", \"type\", \"type\", \"type\" ] }";

    private static final String SUGGESTIONS_FOUND_GREATER_THAN_LIMIT_RESPONSE =
            "{ \"query\": \"locks\", "
                    + "\"suggestions\": [ \"locksmiths\", \"locks\", \"locks & locksmiths\", "
                    + "\"locks & locksmiths automotive\", "
                    + "\"locks & locksmiths key cutting\", \"locks & locksmiths duplicate keys\", "
                    + "\"locksmiths' supplies\", "
                    + "\"locks & locksmiths safes\" ], "
                    + "\"data\": [ \"type\", \"type\", \"type\", \"type\", \"type\", "
                    + "\"type\", \"type\", \"type\" ] }";

    private YellowUrlProxyingController objectUnderTest;

    private final ObjectMapper jacksonMapper = new ObjectMapper();

    private HttpClientService mockHttpClientService;
    private MockHttpServletRequest springMockHttpServletRequest;
    private MockHttpServletResponse springMockHttpServletResponse;
    private HttpResponse mockHttpResponse;


    /**
     * Setup test data.
     *
     * @throws Exception
     *             Thrown if any error occurs.
     */
    @Before
    public void setUp() throws Exception {
        setObjectUnderTest(new YellowUrlProxyingController(
                getMockHttpClientService()));

        setSpringMockHttpServletRequest(new MockHttpServletRequest());
        setSpringMockHttpServletResponse(new MockHttpServletResponse());

        final DeserializationConfig deserializationConfig =
                getJacksonMapper().getDeserializationConfig();
        deserializationConfig.set(Feature.FAIL_ON_UNKNOWN_PROPERTIES, false);

    }

    @Test
    public void testWriteActualResponse() throws Throwable {

        final String[] testUrlToProxyResponses =
                { NO_SUGGESTIONS_FOUND_RESPONSE,
                        SUGGESTIONS_FOUND_LESS_THAN_LIMIT_RESPONSE,
                        SUGGESTIONS_FOUND_EQUALS_LIMIT_RESPONSE,
                        SUGGESTIONS_FOUND_GREATER_THAN_LIMIT_RESPONSE };
        final String[] expectedResponses =
                { NO_SUGGESTIONS_FOUND_RESPONSE,
                        SUGGESTIONS_FOUND_LESS_THAN_LIMIT_RESPONSE,
                        SUGGESTIONS_FOUND_EQUALS_LIMIT_RESPONSE,
                        SUGGESTIONS_FOUND_EQUALS_LIMIT_RESPONSE };

        getSpringMockHttpServletRequest().addParameter("limit", LIMIT_PARAM);

        for (int i = 0; i < testUrlToProxyResponses.length; i++) {

            try {
                final StringReader responseBodyReader =
                        new StringReader(testUrlToProxyResponses[i]);

                EasyMock
                        .expect(getMockHttpResponse().getResponseBodyAsReader())
                        .andReturn(responseBodyReader);

                replay();

                getObjectUnderTest().writeActualResponse(
                        getSpringMockHttpServletRequest(), getMockHttpResponse(),
                        getSpringMockHttpServletResponse());

                final StringReader actualResponseStringReader =
                        new StringReader(getSpringMockHttpServletResponse()
                                .getContentAsString());
                final YellowSearchSuggestions actualYellowSearchSuggestions =
                    getJacksonMapper().readValue(actualResponseStringReader,
                                YellowSearchSuggestions.class);

                final StringReader expectedResponseSringReader =
                        new StringReader(expectedResponses[i]);
                final YellowSearchSuggestions expectedYellowSearchSuggestions =
                    getJacksonMapper().readValue(expectedResponseSringReader,
                                YellowSearchSuggestions.class);

                Assert.assertEquals(
                        "response content is wrong for test response at index: "
                                + i, expectedYellowSearchSuggestions,
                        actualYellowSearchSuggestions);

                verify();

                // Reset mocks and Spring MockHttpServletResponse prior to next
                // iteration.
                setReplayed(false);
                reset();
                setSpringMockHttpServletResponse(new MockHttpServletResponse());
            } catch (final Exception e) {
                throw new Exception(
                        "Error encountered for test response at index: " + i, e);
            }
        }

    }

    public YellowUrlProxyingController getObjectUnderTest() {
        return objectUnderTest;
    }

    /**
     * @param objectUnderTest
     *            the objectUnderTest to set
     */
    private void setObjectUnderTest(
            final YellowUrlProxyingController objectUnderTest) {
        this.objectUnderTest = objectUnderTest;
    }

    /**
     * @return the jacksonMapper
     */
    private ObjectMapper getJacksonMapper() {
        return jacksonMapper;
    }

    /**
     * @return the mockHttpClientService
     */
    public HttpClientService getMockHttpClientService() {
        return mockHttpClientService;
    }

    /**
     * @param mockHttpClientService the mockHttpClientService to set
     */
    public void setMockHttpClientService(final HttpClientService mockHttpClientService) {
        this.mockHttpClientService = mockHttpClientService;
    }

    /**
     * @return the springMockHttpServletRequest
     */
    public MockHttpServletRequest getSpringMockHttpServletRequest() {
        return springMockHttpServletRequest;
    }

    /**
     * @param springMockHttpServletRequest the springMockHttpServletRequest to set
     */
    public void setSpringMockHttpServletRequest(
            final MockHttpServletRequest springMockHttpServletRequest) {
        this.springMockHttpServletRequest = springMockHttpServletRequest;
    }

    /**
     * @return the springMockHttpServletResponse
     */
    public MockHttpServletResponse getSpringMockHttpServletResponse() {
        return springMockHttpServletResponse;
    }

    /**
     * @param springMockHttpServletResponse the springMockHttpServletResponse to set
     */
    public void setSpringMockHttpServletResponse(
            final MockHttpServletResponse springMockHttpServletResponse) {
        this.springMockHttpServletResponse = springMockHttpServletResponse;
    }

    /**
     * @return the mockHttpResponse
     */
    public HttpResponse getMockHttpResponse() {
        return mockHttpResponse;
    }

    /**
     * @param mockHttpResponse the mockHttpResponse to set
     */
    public void setMockHttpResponse(final HttpResponse mockHttpResponse) {
        this.mockHttpResponse = mockHttpResponse;
    }

}
