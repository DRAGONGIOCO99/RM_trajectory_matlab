function [P, sf]=segmento(p1,p2,s)

sf=norm(p2-p1);
% s=linspace(0,sf,ceil(1000*sf));
P=p1+(s.*(p2-p1))/sf;
end