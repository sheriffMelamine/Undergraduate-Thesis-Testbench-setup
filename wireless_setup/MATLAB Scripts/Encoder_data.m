%%

n = 200;

global x_r;
global t_r;
global x_p;
global t_p;
global x_y;
global t_y;

x_r=[];
t_r=[];
x_p=[];
t_p=[];
x_y=[];
t_y=[];


myMQTT = mqttclient('tcp://192.168.0.100',Port=1883,Username="aiferdous",Password="12341234");
mySub_r = subscribe(myMQTT,"Roll/angle",Callback=@callback_r);
mySub_p = subscribe(myMQTT,"Pitch/angle",Callback=@callback_p);
mySub_y = subscribe(myMQTT,"Yaw/angle",Callback=@callback_y);

function callback_r(~,data)
    global x_r;
    global t_r;
    
    if length(x_r)<=n
        temp=jsondecode(data);
        x_r=[x_r temp.angle];
        t_r=[t_r temp.time];
    end
end
function callback_p(~,data)
    global x_p;
    global t_p;
    
    if length(x_p)<=n
        temp=jsondecode(data);
        x_p=[x_p temp.angle];
        t_p=[t_p temp.time];
    end
end
function callback_y(~,data)
    global x_y;
    global t_y;
    
    if length(x_y)<=n
        temp=jsondecode(data);
        x_y=[x_y temp.angle];
        t_y=[t_y temp.time];
    end
end