clear 
close all
clc

%%  Ori trajectory 
Ts=0.001;
eta_1=[pi/2 0 -pi/2]';  % pi/2 su x  --- -pi/2 su z
eta_2=[0 -pi/2 -pi]'; % rotazioni rispetto terna corrente postmoltiplicazioni 
                        % pi/2 rispetto a y ---> -pi rispetto a z corrente 

eta_3=[0 pi/2 pi/2]';   % pi/2 su z  --- pi/2 su y
eta_4=[0 pi/2 pi/2]';   % pi/2 su z  --- pi/2 su y

eta_5=[0 pi/2 0]';
eta_6=eta_5;
eta_7=eta_6;


R0=[-0.924513 0.0135496 0.38091;  % R_e^0 
    0.0932341 0.977044 0.191552;
    -0.36957 0.212609 -0.904553];
eul = rotm2eul(R0,"XYZ"); % orienation of the first desired frame respect to zero frame 
eta_0=rad2deg(eul);
R1 = eul2rotm([pi/2 0 -pi/2],"XYZ");
R2 = eul2rotm([0 -pi/2 pi],"XYZ");
R3 = eul2rotm([-pi/2 0 pi/2],"XYZ");
R4 = R3;
R5 = eul2rotm([0 pi/2 0],"XYZ");
R6 = R5;
R7 = R5;


%% time law theta
tk=[0 ,4, 8, 12, 16, 20, 24, 28]; % tempo di simulazione N*T durata tot traiettoria 

% calcolo thetaf1 e R01
[thetaf1,r1,R01]=asse_angolo(R0,R1);
R_a01=R_asse_angolo(r1,thetaf1);
[theta_1, theta_dot_1, theta_dot_dot_1,theta1,delta_1]=trapezoidal_profile(tk(1),tk(2),0,thetaf1,tk(end),0,0);
t1=tk(1):Ts:tk(2);
R_01d=zeros(3*length(t1),3);

for i=1:3:3*length(t1)   
R_01d(i:i+2,:) = R0*R_asse_angolo(r1,theta_1(i));
end
save('R_01d.txt','R_01d','-ascii','-double')

% calcolo thetaf2 e R12
[thetaf2,r2,R12]=asse_angolo(R1,R2);
R_a12=R_asse_angolo(r2,thetaf2);
[theta_2, theta_dot_2, theta_dot_dot_2,theta2,delta_3]=trapezoidal_profile(tk(2),tk(3),0,thetaf2,tk(end),0,0);
t1=tk(2):Ts:tk(3);
R_12d=zeros(3*length(t1),3);

for i=1:3:3*length(t1)   
R_12d(i:i+2,:) = R1*R_asse_angolo(r2,theta_2(i));
end
save('R_12d.txt','R_12d','-ascii','-double')

% calcolo thetaf3 e R23
[thetaf3,r3,R23]=asse_angolo(R2,R3);
R_a23=R_asse_angolo(r3,thetaf3);
[theta_3, theta_dot_3, theta_dot_dot_3,theta3,delta_3]=trapezoidal_profile(tk(3),tk(4),0,thetaf3,tk(end),0,0);
t1=tk(3):Ts:tk(4);
R_23d=zeros(3*length(t1),3);

for i=1:3:3*length(t1)   
R_23d(i:i+2,:) = R2*R_asse_angolo(r3,theta_3(i));
end
save('R_23d.txt','R_23d','-ascii','-double')

% calcolo thetaf4 e R45
[thetaf4,r4,R45]=asse_angolo(R4,R5);
R_a45=R_asse_angolo(r4,thetaf4);
[theta_4, theta_dot_4, theta_dot_dot_4,theta4,delta_4]=trapezoidal_profile(tk(5),tk(6),0,thetaf3,tk(end),0,0);
t1=tk(5):Ts:tk(6);
R_45d=zeros(3*length(t1),3);

for i=1:3:3*length(t1)   
R_45d(i:i+2,:) = R4*R_asse_angolo(r4,theta_4(i));
end
save('R_45d.txt','R_45d','-ascii','-double')





































