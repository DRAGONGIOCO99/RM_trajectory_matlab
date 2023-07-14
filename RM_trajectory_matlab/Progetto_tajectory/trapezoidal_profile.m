function [s, s_dot, s_dotdot,s_primo,delta_now]=trapezoidal_profile(ti,tf,pi,pf,t_tot,is_viapoint,delta)

s_i=0;
s_f=norm(pf-pi);
dt=tf-ti;

s_c_dot=1.5*abs(s_f-s_i)/dt;
tc=(s_i-s_f+s_c_dot*dt)/s_c_dot;
s_c_dotdot=s_c_dot/tc;
delta_now=delta;
Ts=0.01;

t=linspace(0,dt,dt/Ts);



% if is_viapoint==0
% for k=1:length(t)
%     if t(k)<=tc
%         s_primo(k)=s_i+(1/2)*s_c_dotdot*t(k).^2;
%         s_dot_primo(k)=s_c_dotdot*t(k);
%         s_dotdot_primo(k)=s_c_dotdot;
%     else if (t(k)>tc && t(k)<=dt-tc)
%             s_primo(k)=s_i+s_c_dotdot*tc*(t(k)-tc/2);
%             s_dot_primo(k)=s_c_dotdot*tc;
%             s_dotdot_primo(k)=0;
%     else if (t(k)>dt-tc && t(k)<=dt)
%             s_primo(k)=s_f-(1/2)*s_c_dotdot*(dt-t(k)).^2;
%             s_dot_primo(k)=s_c_dotdot*(dt-t(k));
%             s_dotdot_primo(k)=-s_c_dotdot;
%         end
%         end
%     end
% end
% else
%     for k=1:length(t)+delta*1000
%     if t(k)<=delta
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

l=linspace(0,ti,ti/Ts);            % intervallo temporale in cui metto s=0
m=linspace(ti+Ts,tf,dt/Ts);     % intervallo temporale in cui vale s_primo

if is_viapoint==0
    s(1:length(l))=0;
    s(length(l)+1:length(l)+length(m))=s_primo;
    s(length(l)+length(m)+1:t_tot/Ts)=norm(pf-pi);
%% 

    s_dot(1:length(l))=0;
    s_dot(length(l)+1:length(l)+length(m))=s_dot_primo;
    s_dot(length(l)+length(m)+1:t_tot/Ts)=0;

    s_dotdot(1:length(l))=0;
    s_dotdot(length(l)+1:length(l)+length(m))=s_dotdot_primo;
    s_dotdot(length(l)+length(m)+1:t_tot/Ts)=0;
    
else
    s(1:length(l)-delta/Ts)=0;
    s(length(l)-delta/Ts+1:length(l)+length(m)-delta/Ts)=s_primo;
    s(length(l)+length(m)-delta/Ts+1:t_tot/Ts)=norm(pf-pi);

    s_dot(1:length(l)-delta/Ts)=0;
    s_dot(length(l)-delta/Ts+1:length(l)+length(m)-delta/Ts)=s_dot_primo;
    s_dot(length(l)+length(m)-delta/Ts+1:t_tot/Ts)=0;

    s_dotdot(1:length(l)-delta/Ts)=0;
    s_dotdot(length(l)-delta/Ts+1:length(l)+length(m)-delta/Ts)=s_dotdot_primo;
    s_dotdot(length(l)+length(m)-delta/Ts+1:t_tot/Ts)=0;

end