function PAR = par(wavelength, absoluteSpectrum, IT)
    wavelengthRange = [680 698];
    range = diff(wavelengthRange);

    % extract the subwavelength
    indices = wavelength >= wavelengthRange(1) & wavelength <= wavelengthRange(2);
    sub_wavelength = wavelength(indices);
    sub_spectrum = absoluteSpectrum(indices);

    sub_spectrum = sub_spectrum * 100; % (μW/cm^2)
    
    h = 6.626E-34; % Planck constant (J*s)
    c = 299792458; % Speed of light (m/s)
    lambda = linspace(wavelengthRange(1), wavelengthRange(2), range * 5);
    E = h * c ./ (lambda * 1E-9); % (m)
    
    A_cm2 = 8.66E-5; % Fiber collection area
    A_m2 = A_cm2 * 0.0001;
    N_A = 6.022E+23; % Avogadro’s constant
    
    sub_spectrum = interp1(sub_wavelength, sub_spectrum, lambda, 'spline');
    
    integrand_values = (sub_spectrum * A_cm2 * IT) ./ (E * N_A);
    integral_result = trapz(lambda, integrand_values);
    
    PAR = integral_result / (A_m2 * IT);
end