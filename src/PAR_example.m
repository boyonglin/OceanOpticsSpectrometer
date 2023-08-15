clc; clear;

IT = 1; % integration time (s)

wavelength_range = [400 700];
fileDir = '../../04_Data/00_Solar Spectrum';
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
disp(PAR)

disp(R_PAR)

%% Read file data generated by OceanView
function [sub_wavelength, sub_intensity] = ReadTxtFiles(fileDir, filename, wavelength_range)
% open the file for reading
fullpath = fullfile(fileDir, [filename, '.txt']);
fid = fopen(fullpath, 'r');

% initialize the arrays to hold the data
wavelength = [];
intensity = [];

% read each line of the file
while ~feof(fid)
    line = fgetl(fid);

    % check if there is any non-numeric data in the line
    if isnan(str2double(regexp(line, '[^\s]+', 'match')))

        % if there is, skip this line and move on to the next one
        continue;
    end

    % if all the data in the line is numeric, extract the two columns
    % and save them in the arrays
    data = str2num(line);
    if ~isempty(data)
        wavelength = [wavelength; data(1)];
        intensity = [intensity; data(2)];
    end
end

% find the indices of the elements within the range
indices = wavelength >= wavelength_range(1) & wavelength <= wavelength_range(2);

% extract the subwavelength
sub_wavelength = wavelength(indices);
sub_intensity = intensity(indices);

fclose(fid);
end