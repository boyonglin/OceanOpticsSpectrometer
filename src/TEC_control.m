function TEC_control(spectrometerIndex)
    % Connect the spectrometer
    import('com.oceanoptics.omnidriver.api.wrapper.Wrapper');
    wrapper = Wrapper();
    wrapper.openAllSpectrometers();
    % Reads the Printed Circuit Board Temperature
    if wrapper.isFeatureSupportedBoardTemperature(spectrometerIndex)
        boardTemperature = wrapper.getFeatureControllerBoardTemperature(spectrometerIndex);
        temperatureCelsius = boardTemperature.getBoardTemperatureCelsius();
        disp(['board temperature = ' num2str(temperatureCelsius)]);
    end
    
    % Reads the temperature of the spectrometer detector
    if wrapper.isFeatureSupportedThermoElectric(spectrometerIndex)
        tecController = wrapper.getFeatureControllerThermoElectric(spectrometerIndex);
        actualTemperature = tecController.getDetectorTemperatureCelsius();
        disp(['detector temperature = ' num2str(actualTemperature)]);
        
        % If you want to control the temperature, setTECEnable() MUST be set to true
        % tecController.setTECEnable(true);
        % tecController.setFanEnable(true); % turn the fan on (optional)
        
        % the TE cooler of the QE65000 is capable of dropping the temperature ...
        % of the CCD by 30-43 degrees Celsius below the ambient temperature
        % desiredTemperature = -3; % degrees Celsius
        % tecController.setDetectorSetPointCelsius(desiredTemperature);
    end

    % Clean up
    wrapper.closeAllSpectrometers();
end