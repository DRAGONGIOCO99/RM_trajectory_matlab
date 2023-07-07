function [P,l]=circ(c,p1,ang,R,sc)

rho=norm(p1-c);
l=abs(ang*rho);
% sc=linspace(0,l,ceil(1000*l));
Pprimo=[rho*cos(sc/rho); rho*sin(sc/rho); zeros(1,length(sc))];
P=c+R*Pprimo;
end

