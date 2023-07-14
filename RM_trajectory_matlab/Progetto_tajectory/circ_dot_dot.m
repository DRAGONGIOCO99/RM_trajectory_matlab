function [P,l]=circ_dot_dot(c,p1,ang,R,sc,sc_dot,sc_dot_dot)

rho=norm(p1-c);
l=abs(ang*rho);
% sc=linspace(0,l,ceil(1000*l));
Pprimo=[-((sc_dot.^2).*cos(sc/rho))./rho-(sc_dot_dot).*sin(sc/rho)...
    ; -((sc_dot.^2).*sin(sc/rho))./rho+(sc_dot_dot).*cos(sc/rho); zeros(1,length(sc))];
P=R*Pprimo;
end

