function [P,l]=circ_dot(c,p1,ang,R,sc,sc_dot)

rho=norm(p1-c);
l=abs(ang*rho);
% sc=linspace(0,l,ceil(1000*l));
Pprimo=[-sc_dot.*sin(sc/rho); sc_dot.*cos(sc/rho); zeros(1,length(sc))];
P=R*Pprimo;
end

