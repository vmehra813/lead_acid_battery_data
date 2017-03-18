%% Script for Importing Data from 100Ah Universal Lead-Acid Battery
% Charge/discharge protocol based on Texas Instrument's ChemID Fuel Gauage
% Parameter Selection Tool

% Data taken at 5 second instruments

%% Import the data
% Change path for spreadsheet on local computer! 
[~, ~, raw] = xlsread('/Users/vmehra813/Dropbox (MIT)/ulink_matlab/100Ah/Batt_IV_Data_100Ah_071116_FINAL_VM_ACM.xlsx','Calibrated Data');
raw = raw(2:end,:);
raw(cellfun(@(x) ~isempty(x) && isnumeric(x) && isnan(x),raw)) = {''};

%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
data = reshape([raw{:}],size(raw));

%% Allocate imported array to column variable names
Time = data(:,1);
TimeElapsed = data(:,2);
AmbientTemp = data(:,3);
CurrentDigital = data(:,4);
CurrentRaw = data(:,5);
CurrentCalibrated = data(:,6);
VoltageDigital = data(:,7);
VoltageRaw = data(:,8);
VoltageCalibrated = data(:,9);
BatteryTemp = data(:,10);
BatteryTempRaw = data(:,11);
BatteryTempCalibrated = data(:,12);

%% Clear temporary variables
clearvars data raw R;


%% Plot Results
figure(1);
plotyy(Time,CurrentCalibrated,Time,VoltageCalibrated);
legend('Current','Voltage');
xlabel('Time Elapsed in 5 Second Increments');
title('Full Charge/Discharge Cycle: 100Ah Pb-Acid Battery');


figure(2);
plot(CurrentCalibrated,'r');
hold on;
plot(VoltageCalibrated,'g');
plot(BatteryTempCalibrated,'c');
legend('Current','Voltage','Temperature (C)');
title('Full Charge/Discharge Cycle: 100Ah Pb-Acid Battery: I/V/Temp');
xlabel('Time Elapsed in 5 Second Increments');





