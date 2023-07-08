function [theta_f,ri,Rif] = asse_angolo(Ri,Rf)

Rif=Ri'*Rf;
theta_f=acos( (Rif(1,1)+Rif(2,2)+Rif(3,3)-1)/2);
ri=1/(2*sin(theta_f))*[Rif(3,2)-Rif(2,3);Rif(1,3)-Rif(3,1);Rif(2,1)-Rif(1,2)] ;

end