function [P, sf]=segmento_dot(p1,p2,s)

sf=norm(p2-p1);
% s=linspace(0,sf,ceil(1000*sf));
P=(s.*(p2-p1))/sf;
end