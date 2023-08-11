clc; clear;

longitude = 120.8108;
latitude = 23.5084;
elevation = 2413.4;
pressure = 1014;
temperature = 25;
slope = 0;
azm_rotation = 0;
timezone = +8;

current_date_time_utc = datetime('now', 'TimeZone', num2str(timezone, '+%d'));
fmt = 'yyyy-MM-dd-HH-mm-ss';
str = string(current_date_time_utc, fmt);
parts = str2double(strsplit(str, '-'));
year = parts(1);
month = parts(2);
day = parts(3);
hour = parts(4);
minute = parts(5);
second = parts(6);

[zenith, azimuth, sunrise, sunset] = spa(year, month, day, hour, minute, second, timezone, ...
    longitude, latitude, elevation, pressure, temperature, slope, azm_rotation, 1);

now = string(current_date_time_utc, 'HH:mm:ss');
r = datenum(sunrise);
s = datenum(sunset);
n = datenum(now);
if n > r && n < s
    disp('Diurnal:       day')
else
    disp('Diurnal:       Nighttime')
end
