%%This Script Converts the excel file of the PWM signal profile to comma
%%separated text which is the C++ style representation of an array. This
%%will make things easier as the text can just be copied to the arduino
%%sketch and pasted to the array definition.

%traj_mpc.xlsx file is the example excel file generated from the data of
%rps_to_pwm_conversion.m script which contains first column as the time (s)
%and latter four columns as the motor speed data pwm signal thereof.

traj_mpc = readtable("traj_mpc.xlsx", opts, "UseExcel", false);

data = table2array(traj2mpc);


a1='mA[] = {';
a2='mB[] = {';
a3='mC[] = {';
a4='mD[] = {';
for i=1:length(data(:,1))
      a1=[a1 int2str(data(i,2)) ','];
      a2=[a2 int2str(data(i,3)) ','];
      a3=[a3 int2str(data(i,4)) ','];
      a4=[a4 int2str(data(i,5)) ','];
end
a1(end)='}';
a2(end)='}';
a3(end)='}';
a4(end)='}';
a1= [a1 ';'];
a2= [a2 ';'];
a3= [a3 ';'];
a4= [a4 ';'];
writelines(a1,"traj_mpc.txt");
writelines(a2,"traj_mpc.txt",WriteMode="append");
writelines(a3,"traj_mpc.txt",WriteMode="append");
writelines(a4,"traj_mpc.txt",WriteMode="append");


%traj_lqi.xlsx file is similarly the example excel file generated from the data of
%rps_to_pwm_conversion.m script which contains first column as the time (s)
%and latter four columns as the motor speed data pwm signal thereof.

traj_lqi = readtable("C:\Users\aibab\Downloads\pwm_testbench_final\traj_lqi.xlsx", opts, "UseExcel", false);

data = table2array(traj_lqi);


a1='mA[] = {';
a2='mB[] = {';
a3='mC[] = {';
a4='mD[] = {';
for i=1:length(data(:,1))
      a1=[a1 int2str(data(i,2)) ','];
      a2=[a2 int2str(data(i,3)) ','];
      a3=[a3 int2str(data(i,4)) ','];
      a4=[a4 int2str(data(i,5)) ','];
end
a1(end)='}';
a2(end)='}';
a3(end)='}';
a4(end)='}';
a1= [a1 ';'];
a2= [a2 ';'];
a3= [a3 ';'];
a4= [a4 ';'];
writelines(a1,"traj_lqi.txt");
writelines(a2,"traj_lqi.txt",WriteMode="append");
writelines(a3,"traj_lqi.txt",WriteMode="append");
writelines(a4,"traj_lqi.txt",WriteMode="append");

%Generated text files can be used to conveniently copy paste the array to the
%arduino sketch saved in pwm_calibration_traj.cpp file.
