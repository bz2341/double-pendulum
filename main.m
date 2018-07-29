m=100000;%这个参数是可以调的
L=1;%这个参数是可以调的
theta1=(10/20)*pi;%这个参数是可以调的
theta2=(10/20)*pi;%这个参数是可以调的
t=linspace(0,20,500);%这个参数是可以调的
[T,Y]=ode45(@(t,x)double_pendulum(t,x,m,L),t,[theta1,theta2,0,0]);
x=[L*sin(Y(:,1)),L*sin(Y(:,1))+L*sin(Y(:,2))];
y=[-L*cos(Y(:,1)),-L*cos(Y(:,1))-L*cos(Y(:,2))];
ang=Y(:,1:2)*180/pi;
figure('Color','white')
subplot(2,1,1)
plot(T,ang,'LineWidth',2)
hh1(1)=line(T(1),ang(1,1),'Marker','.','MarkerSize',20,'Color','b');
hh1(2)=line(T(1),ang(1,2),'Marker','.','MarkerSize',20,'Color','r');
xlabel('time (sec)')
ylabel('angle (deg)')
subplot(2,1,2)
hh2=plot([0,x(1,1);x(1,1),x(1,2)],[0,y(1,1);y(1,1),y(1,2)],'.-','MarkerSize',20,'LineWidth',2);
axis equal
axis([-2*L 2*L -2*L 2*L])
ht=title(sprintf('Time: %0.2f sec',T(1)));
pos=get(gcf,'Position');
width=pos(3);
height=pos(4);
mov=zeros(height,width,1,length(T));
for id=1:length(T)
   set(hh1(1),'XData',T(id),'YData',ang(id, 1))
   set(hh1(2),'XData',T(id),'YData',ang(id, 2))
   set(hh2(1),'XData',[0,x(id,1)],'YData',[0,y(id,1)])
   set(hh2(2),'XData',x(id, :),'YData',y(id, :))
   set(ht,'String',sprintf('Time: %0.2f sec',T(id)))
   
     frame=getframe(gcf);  
     im=frame2im(frame);
     [I,map]=rgb2ind(im,20);
     if id==1
         imwrite(I,map,'doublependulumanimation.gif','gif','Loopcount',inf,'DelayTime',0.5);
     else
       imwrite(I,map,'doublependulumanimation.gif','gif','WriteMode','append','DelayTime',0.5);
     end
end

