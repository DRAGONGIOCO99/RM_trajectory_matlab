clc ;
clear ;
close all;
%% prova def

% nomefile2 = fopen ( 'time.txt' , 'r');
% time = fscanf ( nomefile2 , '%f ' , [1 inf] );
% time=time';
% fclose(nomefile2);

% Importa i dati dal file di testohh
% eo = importdata('ERRORE_CLIK_or.txt');
ep = importdata('ERRORE_CLIK_pos.txt');
Pd = importdata('xd.txt');
Pe = importdata('xe.txt');
t=linspace(0,28,length(ep));

%% plot
figure()
plot(t,ep,'LineWidth',1)
grid("on")

% figure()
% plot(t,eo,'LineWidth',1)
% grid("on")

figure
plot3(Pd(:,1),Pd(:,2),Pd(:,3),'b','LineWidth',1.5)
hold on
plot3(Pe(:,1),Pe(:,2),Pe(:,3),'r','LineWidth',1.5)
hold on
grid("on")
 

figure()
plot(t,Pd,'LineWidth',1)
grid("on")
figure()
plot(t,Pe,'LineWidth',1)
grid("on")




