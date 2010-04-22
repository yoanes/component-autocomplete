package au.com.sensis.mobile.web.component.autocomplete.device;

import au.com.sensis.mobile.web.component.autocomplete.device.generated.DeviceConfig;
import au.com.sensis.mobile.web.component.core.device.AbstractDeviceConfigRegistry;
import au.com.sensis.mobile.web.component.core.device.generated.AbstractDeviceConfig;
import au.com.sensis.wireless.common.utils.jaxb.XMLBinder;

/**
 * Registry of device configuration for the current component.
 *
 * @author Adrian.Koh2@sensis.com.au
 */
public class AutoCompleteDeviceConfigRegistry extends AbstractDeviceConfigRegistry {

    /**
     * Default constructor.
     *
     * @param deviceConfigClasspath
     *            device-config.xml file to use on the classpath.
     * @param xmlBinder
     *            {@link XMLBinder} to use to parse the config file.
     */
    public AutoCompleteDeviceConfigRegistry(final String deviceConfigClasspath,
            final XMLBinder xmlBinder) {
        super(deviceConfigClasspath, xmlBinder);
    }

    /**
     * {@inheritDoc}
     */
    @Override
    protected Class<? extends AbstractDeviceConfig> getDeviceConfigType() {
        return DeviceConfig.class;
    }


}
