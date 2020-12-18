%%%%%%%%%%%%%%%%%%%%Defination of Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear all;

Ts=1/(50e3);                                            %开关频率设置 20K
Ts_FEA = 1e-7;
flg_loss = 0;
flg_pwm = 0;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%  电机参数  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Pn=65e3;                                                %电机额定功率131kW
Tn=155;%155.9;                                          %电机额定转矩
Tmax=Tn*1.2;                                            %电机峰值转矩230N.m
n_n=4000;                                               %额定转速(rpm)
Umax=370;                                               %峰值电压(V)
Un=Umax/1.2;                                            %额定相电压(V)
Imax=450*sqrt(2);                                       %峰值电流(A)
In=Imax/1.2;                                            %额定电流(A)
p=4;                                                    %极对数
f1=n_n*p/60;                                            %额定频率

k=Imax/In;                                            %过载系数
model=1;                                              %1个三相绕组
Jm=0.00247*2;                                          %转动惯量
B=0.00002 ;                                           %摩擦系数
faif=0.047;                                          %磁链计算
Rs=8.5e-3;                                            %定子电阻 (欧姆)   
Ld=0.08e-3;                                           %d-q电感
Lq=0.28e-3;
Ls=0.199e-3;
%%%%%%%%%%%%%%%%%%%%%Converter Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
VDC=370;                                              %直流母线电压(V)


%%%%%%%%%%%%%%%%%%%%% Current Controller Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fc=2000;                            %电流环带宽频率（Hz）
wc=fc*2*pi;

Kpc=Ld*wc;                          %电流控制器比例增益
Kic=Rs*wc;                          %电流控制器积分项增益
Kawc=Kic/Kpc;                       %anti-windup防积分饱和增益         

duty_limit=2/sqrt(3);                     %占空比限幅值
%index_limit=0.8;                                          %Duty limit index for q1d1 regulator
%duty_limit_1=duty_limit*index_limit;                      %Duty limit for q1d1 regulator
%duty_limit_3=duty_limit*sqrt(1-index_limit)               %Duty limit for q3d3 regulator

%%%%%%%%%%%%%%%%%%%%% Speed Controller Parameters%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
n=4000;
%k0=0.99999;
KT=3/2*p*faif;                       %电机转矩电流系数
fs=20;                              %电机速度环带宽频率(Hz)
ws=fs*2*pi;                             %电机速度环带宽角频率(Hz)
yita=0.707;                          %电机速度环阻尼比

Kis=ws^2*Jm/KT;                     %速度控制器积分项增益                  
Kps=yita*ws*2*Jm/KT;                 %速度控制器比例增益
kaws=Kis/Kps;                        %anti-windup防积分饱和增益 
Iq_limit=60;                        %电流限幅值，为1.5倍的额定电流

Ts_spc=Ts;                               %速度环采样频率
%Ts1=1e-5;                                
%Ts2=1e-5;                                 

Ts_dead=0.5e-6;                              %死区时间设置