close all;
clear;

%load D1 and show y(t)'s
s=load('D1.mat');
D1_data=s.D1_data;
set(figure,'Position',[100 400 1000 600]);
for i=1:length(D1_data)
    plot(D1_data{i}.t,D1_data{i}.y);hold on;
end
xlabel('Time, [s]');ylabel('Measured y(t)');set(gca,'FontName','Arial','FontSize',22);

%evaluate response of subsystem 
a=[1,1,1,1,1];
e=[0.5,0.5,0.5,0.5];
response=yfun(a,e);
set(figure,'Position',[100 400 1000 600]);plot(response.t,response.y,'Linewidth',2);xlabel('Time, [s]');ylabel('Predicted y(t)');set(gca,'FontName','Arial','FontSize',22);

%load nominal design
s=load('baseline-design');
theta_baseline=s.theta_baseline;

%evaluate response of integrated system for baseline design
response=zfun(a,e,theta_baseline);
set(figure,'Position',[100 400 1000 600]);
subplot(211);plot(response.t,response.z1,'Linewidth',2);hold on;ylabel('Predicted z_1(t)');
subplot(212);plot(response.t,response.z2,'Linewidth',2);hold on;xlabel('Time, [s]');ylabel('Predicted z_2(t)');

%show limits of z1(t) and z2(t) in the reliability requirements
subplot(211);plot([2.5,5],0.02*[1,1],'r','Linewidth',2);h=plot([2.5,5],-0.02*[1,1],'r','Linewidth',2);legend(h,'Limits');set(gca,'FontName','Arial','FontSize',22);
subplot(212);plot([0,5],4*[1,1],'r','Linewidth',2);plot([0,5],-4*[1,1],'r','Linewidth',2);set(gca,'FontName','Arial','FontSize',22);

%evaluate reliability requirements
g=gfun(a,e,theta_baseline)
