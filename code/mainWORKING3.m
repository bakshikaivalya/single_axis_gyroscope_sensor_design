% AE - 6210 Advanced Dynamics I
% Computer Aided Project
% Unit tests on implemented functions

%% Cleaning and preparing the workspace
clc, close all, clear all;

% Global values to give to the model function
global tData
global qData

% Linear mode
global C
global Ixx
global Izz
global K
global omega
% Non linear
global k
global l
global r
global d
global c

%% Loading data
data = load('Flight_Data.txt');

tData = data(:,1);
xData = data(:,2);
yData = data(:,3);
zData = data(:,4);
uData = data(:,5);
vData = data(:,6);
wData = data(:,7);
phiData = data(:,8);
thetaData = data(:,9);
psiData = data(:,10);
pData = data(:,11);
qData = data(:,12);
rData = data(:,13);

%% Design variables
% Units in USI

% Casing
r = 0.04;
d = 0.03;

% Disk
mD = 0.1;
R = 0.03;
Rint = 0.01;
H = 0.01;
RPM = 40000;
omega = RPM*pi/30;

% Frame
m1 = 0.005;
m2 = 0.005;
m3 = 0.005;
h = 0.01;
e = 0.0005;
l = 0.079;

% Dampers
% c = 0.4;
% c = 0.63365
% c = 1.2673;
% c = 0.517008;
c = 0.1;

% Springs
% k = 2;
% k = 5.10185;
% k = 20.4074;
% k = 10.471;
k = 25;

%% Intermediate variables
Ixx = mD/2*(R^2+Rint^2);
Izz = mD/4*(R^2+Rint^2+H^2/3);
Isz = m1*(l^2/6 + h^2/6) + m2*(h^2/6 + e^2/6 + (l - e)^2/2) + m3*(Rint^2/4 + (l - e)^2/12);

K = 1/2 * l^2 * (4*k*r^2)/(l^2 + 4*r^2);
C = 1/2*c*l^2;

fprintf('Intermediate variables :\n');
fprintf('Ixx = %f kg.m^2\n',Ixx);
fprintf('Izz = %f kg.m^2\n',Izz);
fprintf('Isz = %f kg.m^2\n',Isz);
fprintf('K = %f kg.m^2/s^2\n',K);
fprintf('C = %f kg.m^2/s\n',C);

%% Second order system variables
xi = C/(2*sqrt(K*Izz));
omega0 = sqrt(K/Izz);
G0 = Ixx*omega/K;

fprintf('\nSecond order system variables :\n');
fprintf('xi = %f\n',xi);
fprintf('omega0 = %f\n',omega0);
fprintf('G0 = %f\n',G0);

%% Step response analysis
tStep = 0:0.001:0.5;
figure, plot(tStep,180/pi*stepResponse(tStep,G0,omega0,xi),'b');
hold on,
plot(tStep,180/pi*G0*ones(size(tStep)),'k')
plot(tStep,180/pi*0.95*G0*ones(size(tStep)),'r--')
plot(tStep,180/pi*1.05*G0*ones(size(tStep)),'r--')
legend('Response (°)','Input step (°)','5 % error cylinder');
title('Step response');
xlabel('t(s)');
ylabel('\theta (t) (°)');
hold off;

% Relative error on first pic with correspondent time
D1rel = exp(-xi*pi/sqrt(1-xi^2));
t1 = xi*pi/(omega0*sqrt(1-xi^2));

% Resonance
omegaR = omega0*sqrt(1-2*xi^2);
Gr = G0/(2*xi*sqrt(1-xi^2));

fprintf('\nStep response caracterization :\n');
fprintf('D1rel = %f at t = %f s\n',D1rel,t1);
fprintf('omega0 = %f rad/s\n',omega0);
fprintf('G0 = %f\n',G0);
if (xi < 0.7)
    fprintf('\tResonance :\n');
    fprintf('\tomegaR = %f rad/s',omegaR);
    fprintf('\tGr = %f\n',Gr);
end

%% Numerical simulation

% Initialization
tspan = [0 tData(end)];
z0 = [0 0];
% Iterations
[tLin, zLin] = ode45(@projfuncLin, tspan, z0);
[t, z] = ode45(@projfunc, tspan, z0);

%% Display
figure, plot(t,180/pi*z(:,1),'b')
hold on,
plot(tLin,180/pi*zLin(:,1),'g')
plot(tData,180/pi*G0*qData,'r')
legend('Output angle \theta (°)','Linearized method','Scaled input pitch rate (scaled °/s)');
title('Gyroscopic device output');
xlabel('t (s)');
hold off;

%% Error
qDataBisLin = interp1(tData,qData,tLin);
errorLin = min(abs((zLin(:,1)-G0*qDataBisLin)./(G0*qDataBisLin)),0.5);
qDataBis = interp1(tData,qData,t);
error = min(abs((z(:,1)-G0*qDataBis)./(G0*qDataBis)),0.5);

figure, plot(t,error,'b');
hold on;
plot(tLin,errorLin,'g');
hold off;
legend('Relative error','Relative error for linearized method');
title('Error');

% Display
fprintf('\n Error :\n');
fprintf('Mean error = %f \t Median error = %f\n',mean(error),median(error));
fprintf('Mean errorLin = %f \t Median errorLin = %f\n',mean(errorLin),median(errorLin));