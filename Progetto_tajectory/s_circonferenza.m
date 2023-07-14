function [s, s_dot, s_dotdot,s_primo,delta_now]=s_circonferenza(ti,tf,pi,pf,t_tot,c,alpha,is_viapoint,delta)
rho=norm(pi-c);
s_i=0;
s_f=abs(alpha*rho);
dt=tf-ti;
delta_now=delta;
s_c_dot=1.5*abs(s_f-s_i)/dt;
tc=(s_i-s_f+s_c_dot*dt)/s_c_dot;
s_c_dotdot=s_c_dot/tc;
Ts=0.01;

delta_t=delta/Ts;


t=linspace(0,dt,dt/Ts);

% if is_viapoint==0
% for k=1:length(t)
%     if t(k)<=tc % accellerazione cost
%         s_primo(k)=s_i+(1/2)*s_c_dotdot*t(k).^2;
%         s_dot_primo(k)=s_c_dotdot*t(k);
%         s_dotdot_primo(k)=s_c_dotdot;
%     else if (t(k)>tc && t(k)<=dt-tc) % velocità costante
%             s_primo(k)=s_i+s_c_dotdot*tc*(t(k)-tc/2);
%             s_dot_primo(k)=s_c_dotdot*tc;
%             s_dotdot_primo(k)=0;
%     else if (t(k)>dt-tc && t(k)<=dt) % decellerazione cost
%             s_primo(k)=s_f-(1/2)*s_c_dotdot*(dt-t(k)).^2;
%             s_dot_primo(k)=s_c_dotdot*(dt-t(k));
%             s_dotdot_primo(k)=-s_c_dotdot;
%         end
%         end
%     end
% end
% 
% else
%     for k=1:length(t)+delta_t
%     if t(k)<=delta  %ritardo
%         s_primo(k)=0;
%         s_dot_primo(k)=0;
%         s_dotdot_primo(k)=0;
%     else if (t(k)>delta && t(k)<=tc+delta) % accellerazione cost
%             s_primo(k)=s_i+(1/2)*s_c_dotdot*t(k).^2;
%             s_dot_primo(k)=s_c_dotdot*t(k);
%             s_dotdot_primo(k)=s_c_dotdot;
%             
%     else if (t(k)>tc+delta && t(k)<=dt-tc+delta) % velocità costante
%             s_primo(k)=s_i+s_c_dotdot*tc*(t(k)-tc/2);
%             s_dot_primo(k)=s_c_dotdot*tc;
%             s_dotdot_primo(k)=0;
%             
%     else if (t(k)>dt-tc+delta && t(k)<=dt+delta) % decellerazione cost
%             s_primo(k)=s_f-(1/2)*s_c_dotdot*(dt-t(k)).^2;
%             s_dot_primo(k)=s_c_dotdot*(dt-t(k));
%             s_dotdot_primo(k)=-s_c_dotdot;
%         end
%         end
%     end
% end
%     
%     end
% end

for k=1:length(t)
    if t(k)<=tc
        s_primo(k)=s_i+(1/2)*s_c_dotdot*t(k).^2;
        s_dot_primo(k)=s_c_dotdot*t(k);
        s_dotdot_primo(k)=s_c_dotdot;
    else if (t(k)>tc && t(k)<=dt-tc)
            s_primo(k)=s_i+s_c_dotdot*tc*(t(k)-tc/2);
            s_dot_primo(k)=s_c_dotdot*tc;
            s_dotdot_primo(k)=0;
    else if (t(k)>dt-tc && t(k)<=dt)
            s_primo(k)=s_f-(1/2)*s_c_dotdot*(dt-t(k)).^2;
            s_dot_primo(k)=s_c_dotdot*(dt-t(k));
            s_dotdot_primo(k)=-s_c_dotdot;
        end
        end
    end
end

l=linspace(0,ti,ti/Ts);           % intervallo temporale in cui metto s=0
m=linspace(ti+0.01,tf,dt/Ts);    % intervallo temporale in cui vale s_primo

% oss: il passo è 1/1000 quindi se ho un un intervallo T dovrò prendere T*1000 punti in mezzo



sprimo_start=length(l)+1;       % è l'istante temporale prima che inizia l'evoluzione di s primo
sprimo_end=length(m)+length(l);  % length(m)+length(l) è l'istante temporale prima che inizia l'evoluzione di s primo

if is_viapoint==0
    
% s(1:sprimo_start-1)=0;
% s(sprimo_start:sprimo_end)=s_primo;
% s(sprimo_end+1:1000*t_tot)=s_f;
% 
% s_dot(1:sprimo_start-1)=0;
% s_dot(sprimo_start:sprimo_end)=s_dot_primo;
% s_dot(sprimo_end+1:1000*t_tot)=0;
% 
% s_dotdot(1:sprimo_start)=0;
% s_dotdot(sprimo_start:sprimo_end)=s_dotdot_primo;
% s_dotdot(sprimo_end+1:1000*t_tot)=0;

s(1:length(l))=0;
s(length(l)+1:length(l)+length(m))=s_primo;
s(length(l)+length(m)+1:t_tot/Ts)=s_f;

s_dot(1:length(l))=0;
s_dot(length(l)+1:length(l)+length(m))=s_dot_primo;
s_dot(length(l)+length(m)+1:t_tot/Ts)=0;

s_dotdot(1:length(l))=0;
s_dotdot(length(l)+1:length(l)+length(m))=s_dotdot_primo;
s_dotdot(length(l)+length(m)+1:t_tot/Ts)=0;

else
%     s(1:sprimo_start-1)=0;
%     s(sprimo_start-delta_t:sprimo_end-delta_t)=s_primo;%(sprimo_start+delta_t:sprimo_end+delta_t);
%     s(length(l)+length(m)-delta_t+1:1000*t_tot)=norm(pf-pi);
% 
%     s_dot(1:length(l)-1000*delta)=0;
%     s_dot(length(l)-1000*delta+1:length(l)+length(m)-1000*delta)=s_dot_primo;%(length(l)+1000*delta:length(l)+length(m)+1000*delta);
%     s_dot(length(l)+length(m)-1000*delta+1:1000*t_tot)=0;
% 
%     s_dotdot(1:length(l)-1000*delta)=0;
%     s_dotdot(length(l)-1000*delta+1:length(l)+length(m)-1000*delta)=s_dotdot_primo;%(length(l)+1000*delta:length(l)+length(m)+1000*delta);
%     s_dotdot(length(l)+length(m)-1000*delta+1:1000*t_tot)=0;

    s(1:length(l)-delta/Ts)=0;
    s(length(l)-delta/Ts+1:length(l)+length(m)-delta/Ts)=s_primo;
    s(length(l)+length(m)-delta/Ts+1:t_tot/Ts)=norm(s_primo(end));
%     s(length(l)+length(m)-1000*delta+1:1000*t_tot)=norm(pf-pi);

    s_dot(1:length(l)-delta/Ts)=0;
    s_dot(length(l)-delta/Ts+1:length(l)+length(m)-delta/Ts)=s_dot_primo;
    s_dot(length(l)+length(m)-delta/Ts+1:t_tot/Ts)=0;

    s_dotdot(1:length(l)-delta/Ts)=0;
    s_dotdot(length(l)-delta/Ts+1:length(l)+length(m)-delta/Ts)=s_dotdot_primo;
    s_dotdot(length(l)+length(m)-delta/Ts+1:t_tot/Ts)=0;

end   


end