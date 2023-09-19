clc; clear;

IT = 1; % integration time (s)

wavelength_range = [400 700];
fileDir = '..\..\..\04_Data\00_Solar Spectrum';
fileName = 'AM0_StandardSpectra';
[solar_wl, solar_int] = ReadTxtFiles(fileDir, fileName, wavelength_range);

R_PAR = par(solar_wl, solar_int, IT);

solar_int = solar_int * 100; % 1 W/(m^2) = 100 μW/(cm^2)

h = 6.626E-34; % Planck constant (J*s)
c = 299792458; % Speed of light (m/s)
lambda = linspace(400, 700, 100); % Discrete values of λ from 400 to 700 nm
E = h * c ./ (lambda * 1E-9); % Convert lambda to meters for correct units

A_cm2 = 8.66E-5; % Fiber collection area
A_m2 = A_cm2 * 0.0001;
N_A = 6.022E+23; % Avogadro’s constant

I_lambda = interp1(solar_wl, solar_int, lambda, 'spline');

integrand_values = (I_lambda * A_cm2 * IT) ./ (E * N_A);
integral_result = trapz(lambda, integrand_values);

PAR = integral_result / (A_m2 * IT);

fprintf('PAR: %f\n', PAR)
fprintf('Red PAR: %f\n', R_PAR)
