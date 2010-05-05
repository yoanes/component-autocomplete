package au.com.sensis.mobile.web.component.autocomplete.datasource;

import java.io.IOException;
import java.io.StringReader;

import javax.servlet.http.HttpServletResponse;

import org.easymock.EasyMock;
import org.junit.Assert;
import org.junit.Before;
import org.junit.Test;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.mock.web.MockHttpServletResponse;
import org.springframework.web.servlet.ModelAndView;

import au.com.sensis.wireless.common.utils.http.HttpClientService;
import au.com.sensis.wireless.common.utils.http.HttpResponse;
import au.com.sensis.wireless.test.AbstractJUnit4TestCase;

/**
 * Controller that transparently proxies a URL.
 *
 * @author Adrian.Koh2@sensis.com.au
 */
public class TransparentUrlProxyingControllerTestCase extends AbstractJUnit4TestCase {

    private TransparentUrlProxyingController objectUnderTest;
    private HttpClientService mockHttpClientService;
    private MockHttpServletRequest springMockHttpServletRequest;
    private MockHttpServletResponse springMockHttpServletResponse;
    private HttpResponse mockHttpResponse;

    @Before
    public void setup() {
        setSpringMockHttpServletRequest(new MockHttpServletRequest());
        setSpringMockHttpServletResponse(new MockHttpServletResponse());
        setObjectUnderTest(
                new TransparentUrlProxyingController(getMockHttpClientService()));
    }

    @Test
    public void testHandleRequestInternalWhenResponseSuccess() throws Exception {

        final String expectedUrl = "http://some.url.com";
        getMockHttpServletRequest().addParameter("url", expectedUrl);

        EasyMock.expect(getMockHttpClientService().get(expectedUrl)).andReturn(
                getMockHttpResponse());

        final String expectedResponseBody = "my response body";
        final StringReader stringReader = new StringReader(expectedResponseBody);
        EasyMock.expect(getMockHttpResponse().getResponseBodyAsReader())
                .andReturn(stringReader);

        replay();

        final ModelAndView modelAndView =
                getObjectUnderTest().handleRequestInternal(
                        getMockHttpServletRequest(),
                        getMockHttpServletResponse());

        verify();

        Assert.assertNull("modelAndView should be null", modelAndView);
        Assert.assertEquals("response content is wrong", expectedResponseBody,
                getMockHttpServletResponse().getContentAsString());
    }

    @Test
    public void testHandleRequestInternalWhenResponseFailure() throws Exception {

        final String expectedUrl = "http://some.url.com";
        getMockHttpServletRequest().addParameter("url", expectedUrl);

        EasyMock.expect(getMockHttpClientService().get(expectedUrl)).andThrow(
                new IOException("test"));

        replay();

        final ModelAndView modelAndView =
            getObjectUnderTest().handleRequestInternal(
                    getMockHttpServletRequest(),
                    getMockHttpServletResponse());

        verify();

        Assert.assertNull("modelAndView should be null", modelAndView);
        Assert.assertEquals("response status is wrong", HttpServletResponse.SC_NOT_FOUND,
                getMockHttpServletResponse().getStatus());
    }

    public void setObjectUnderTest(final TransparentUrlProxyingController objectUnderTest) {
        this.objectUnderTest = objectUnderTest;
    }

    public TransparentUrlProxyingController getObjectUnderTest() {
        return objectUnderTest;
    }

    public void setMockHttpClientService(final HttpClientService httpClientService) {
        mockHttpClientService = httpClientService;
    }

    public HttpClientService getHttpClientService() {
        return mockHttpClientService;
    }

    public void setSpringMockHttpServletRequest(
            final MockHttpServletRequest mockHttpServletRequest) {
        springMockHttpServletRequest = mockHttpServletRequest;
    }

    public MockHttpServletRequest getMockHttpServletRequest() {
        return springMockHttpServletRequest;
    }

    public void setSpringMockHttpServletResponse(
            final MockHttpServletResponse mockHttpServletResponse) {
        springMockHttpServletResponse = mockHttpServletResponse;
    }

    public MockHttpServletResponse getMockHttpServletResponse() {
        return springMockHttpServletResponse;
    }

    /**
     * @return the mockHttpClientService
     */
    public HttpClientService getMockHttpClientService() {
        return mockHttpClientService;
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
