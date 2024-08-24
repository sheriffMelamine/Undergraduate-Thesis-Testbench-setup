%PWM-Rotation.xlsx represents the excel file generated from the experiment
%using the tachometer which contains some inputs of the PWM signal to the
% BLDC motors and their corresponding rotational speed of motor recorded 
% by the tachometer through the Arduino Code

PWMRotation = readtable("PWM-Rotation.xlsx", opts, "UseExcel", false);

data = table2array(PWMRotation);
data = [data(1:end-2,:);data(end,:)];
data(:,2)=data(:,2).*pi/60;
coeff=polyfit(data(:,2),data(:,1),3);
plot(data(:,2),(data(:,2).^[3 2 1 0])*coeff');
x_axis_data=data(:,2);
y_axis_data1=(data(:,2).^[3 2 1 0])*coeff';

%All-Data.xlsx represents the excel file containing the simulated data of
%the 4 motors' speeds from the quadcopter plant simulation. They are input
%as rad/s unit and converted to corresponding PWM signal rounded by the
%following script

AllData = readtable("All-Data.xlsx", opts, "UseExcel", false);
trajectory2 = table2array(AllData);

traj2=trajectory2(2:end,:);
for i=1:8
    traj2(:,i+1)=round((traj2(:,i+1).^[3 2 1 0])*coeff');
end

%traj2 can then be converted to excel file which could be used to in the
%for_arduino.m script
