clear all 
close all
clc

%% definizione punti della traiettoria

scale=0.7;
p0=[0.5 0 0.5]';
p1=scale*[0.5 -0.5 0.3]';
p2=scale*[0 -0.65 0.4]';
p3=scale*[-0.5 -0.5 0.3]';
p4=scale*[-0.5 -0.5 0.6]'; 
p5=scale*[-0.5 -0.25 0.6]'; % semicirconferenza di raggio 0.25 con centro [-0.5 -0.25 0.6] che parte da p4 e arriva a p5
p6=scale*[-0.5 -0.25 0.4]';
p7=scale*[-0.7 -0.25 0.4]';

Ts=0.01;

ro1=scale*0.25/2;
% ro2=0.4;   
c1=scale.*[-0.5 -0.25-0.25/2 0.6]';
% c2=[0 0 0.75]';
R1=eul2rotm([0 0 -pi/2],"XYZ"); % rotazione di "-pi/2" intorno z per allineare asse c verso pto iniziale 
%R1=eul2rotm([-pi 0 pi/2],"XYZ"); % rotazione di "-pi/2" intorno z per allineare asse c verso pto iniziale 

tk=[0 ,8, 12, 16, 20, 24, 28, 32]; % tempo di simulazione N*T durata tot traiettoria 
p=[p0 p1 p2 p3 p4 p5 p6 p7 ];

% angolo orientaento EE
% alfa=[0 -pi 0 teta-pi/2 -teta 0 -pi 0 (teta-pi/2) -teta 0 0 ];
% alfa=[0 -pi 0 0 0 0 -pi 0 0 0 0 0 ];
alfa =[0 -pi/2 0];

%% trapeziodal profile for "s"
[s_1, s_dot_1, s_dot_dot_1,s1,delta_1]=trapezoidal_profile(tk(1),tk(2),p0,p1,tk(end),0,0);
[s_2, s_dot_2, s_dot_dot_2,s2,delta_2]=trapezoidal_profile(tk(2),tk(3),p1,p2,tk(end),0,0);
[s_3, s_dot_3, s_dot_dot_3,s3,delta_3]=trapezoidal_profile(tk(3),tk(4),p2,p3,tk(end),0,0);
[s_4, s_dot_4, s_dot_dot_4,s4,delta_4]=trapezoidal_profile(tk(4),tk(5),p3,p4,tk(end),0,0);
[sc_2, s_dotc_2, s_dot_dotc_2,sc2,deltac_2]=s_circonferenza(tk(5),tk(6),p4,p5,tk(end),c1,-pi,0,0);
[s_5, s_dot_5, s_dot_dot_5,s5,delta_5]=trapezoidal_profile(tk(6),tk(7),p5,p6,tk(end),0,0);
[s_6, s_dot_6, s_dot_dot_6,s6,delta_6]=trapezoidal_profile(tk(7),tk(8),p6,p7,tk(end),0,0);




% % profili trapezoidali orientamento
% [alfa_1,alfa_1_dot,alfa_1_dot_dot,alfa1,delta_alfa1]=trapezoidal_profile(tk(2),tk(4),alfa(1),alfa(2),tk(end),0,0);
% [alfa_2,alfa_2_dot,alfa_2_dot_dot,alfa2,delta_alfa2]=trapezoidal_profile(tk(7),tk(9),alfa(2),alfa(3),tk(end),0,0);



%% plot leggi orarie:

    % definizione tempi:
    ts=linspace(0,tk(end),100*tk(end));
    t=ts;

    % di posizione
    figure 
        plot(t,s_1+s_6+s_2+s_3+s_4+sc_2+s_5,'LineWidth',1)

    % di velocità
    figure
     plot(t,s_dot_1,'LineWidth',1)
     hold on
     plot (t,s_dot_2,'LineWidth',1)
     hold on
     plot(t,s_dot_3,'LineWidth',1)
     hold on
     plot (t,s_dot_4,'LineWidth',1)
     hold on
     plot (t,s_dot_5,'LineWidth',1)
     hold on
     plot (t,s_dotc_2,'LineWidth',1)
     hold on
     plot (t,s_dot_6,'LineWidth',1)
     grid("on")

    

%% trajectory description 

r1= p0+ s_1.*(p1-p0)/norm(p1-p0)+...
    s_2.*(p2-p1)/norm(p2-p1)+...
    s_3.*(p3-p2)/norm(p3-p2)+...
    s_4.*(p4-p3)/norm(p4-p3);
[P4,l4]=circ(c1,p4,pi,R1,sc_2);
% P4(1,:)=-P4(1,:);
r2= p5+ s_5.*(p6-p5)/norm(p6-p5)+...
    s_6.*(p7-p6)/norm(p7-p6);



P=[ r1(:,tk(1)/Ts+1:tk(5)/Ts) ...
      P4(:,tk(5)/Ts+1:tk(6)/Ts) ...
      r2(:,tk(6)/Ts+1:tk(8)/Ts)];%PATH
P=P';
save('Xd.txt','P','-ascii','-double')

P=P';


figure
plot(ts,P)
Xd=timeseries(P,ts);
% % orientamento
% OR1= alfa(1)+alfa_1.*(alfa(2)-alfa(1))/norm(alfa(2)-alfa(1))+alfa_2.*(alfa(3)-alfa(2))/norm(alfa(3)-alfa(2));

%PLOT
% figure 
% plot(Xd,'LineWidth',1);

%%  plot traiettoria
 figure
plot3(P(1,:),P(2,:),P(3,:),'b','LineWidth',1.5)
hold on
plot3(p(1,:),p(2,:),p(3,:),'o','MarkerFaceColor','r')
hold on
 grid("on")

%% traiettoria velocità

r1_dot=  s_dot_1.*(p1-p0)/norm(p1-p0)+...
    s_dot_2.*(p2-p1)/norm(p2-p1)+...
    s_dot_3.*(p3-p2)/norm(p3-p2)+...
    s_dot_4.*(p4-p3)/norm(p4-p3);
[P4_dot,l4]=circ_dot(c1,p4,pi,R1,sc_2,s_dotc_2);
% P4_dot(1,:)=-P4_dot(1,:);
r2_dot=  s_dot_5.*(p6-p5)/norm(p6-p5)+...
    s_dot_6.*(p7-p6)/norm(p7-p6);



P_dot=[ r1_dot(:,tk(1)/Ts+1:tk(5)/Ts) ...
      P4_dot(:,tk(5)/Ts+1:tk(6)/Ts) ...
      r2_dot(:,tk(6)/Ts+1:tk(8)/Ts)];%PATH


P_dot=P_dot';
save('Xd_dot.txt','P_dot','-ascii','-double');
P_dot=P_dot';

figure
plot(ts,P_dot)

%% traiettoria accelerazione
r1_dot_dot=  s_dot_dot_1.*(p1-p0)/norm(p1-p0)+...
    s_dot_dot_2.*(p2-p1)/norm(p2-p1)+...
    s_dot_dot_3.*(p3-p2)/norm(p3-p2)+...
    s_dot_dot_4.*(p4-p3)/norm(p4-p3);
[P4_dot_dot,l4]=circ_dot_dot(c1,p4,pi,R1,sc_2,s_dotc_2,s_dot_dotc_2);
% P4_dot_dot(1,:)=-P4_dot_dot(1,:);
r2_dot_dot=  s_dot_dot_5.*(p6-p5)/norm(p6-p5)+...
    s_dot_dot_6.*(p7-p6)/norm(p7-p6);



P_dot_dot=[ r1_dot_dot(:,tk(1)/Ts+1:tk(5)/Ts) ...
      P4_dot_dot(:,tk(5)/Ts+1:tk(6)/Ts) ...
      r2_dot_dot(:,tk(6)/Ts+1:tk(8)/Ts)];%PATH


P_dot_dot=P_dot_dot';
save('Xd_dot_dot.txt','P_dot_dot','-ascii','-double')
P_dot_dot=P_dot_dot';


figure
plot(ts,P_dot_dot)



%PLOT
% figure 
% plot(Xd_dot_dot,'LineWidth',1);
