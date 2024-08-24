%%This script should be run after the Encoder data is received by the
%%Encoder_data.m script. This will post process the data setting the first
%%datapoints as the reference zero and normalizing the angle in the range
%%of -180 degree to 180 degree

t_step = 0:50:10000;

roll_dir=1;
pitch_dir=1;
yaw_dir=1;

x_ri=x_r(1,1);
t_ri=t_r(1,1);
x_pi=x_p(1,1);
t_pi=t_p(1,1);
x_yi=x_y(1,1);
t_yi=t_y(1,1);

t_r_cal=t_r-t_ri;
t_p_cal=t_p-t_pi;
t_y_cal=t_y-t_yi;

x_r_cal=roll_dir*angle_norm(x_r,x_ri);
x_p_cal=pitch_dir*angle_norm(x_p,x_pi);
x_y_cal=yaw_dir*angle_norm(x_y,x_yi);

roll=interp1(t_r_cal,x_r_cal,t_step);
pitch=interp1(t_p_cal,x_p_cal,t_step);
yaw=interp1(t_y_cal,x_y_cal,t_step);

writetable(array2table([t_step'/1000 roll' pitch' yaw']),"roll_pitch_yaw.xlsx");

function ang =angle_norm(encod,cal)
    ang=encod-cal+360*(encod-cal<-180)-360*(encod-cal>180);
end
