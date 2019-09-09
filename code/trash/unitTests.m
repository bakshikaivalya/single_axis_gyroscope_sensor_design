% AE - 6210 Advanced Dynamics I
% Computer Aided Project
% Unit tests on implemented functions

%% Cleaning and preparing the workspace
clc, close all, clear all;

path(path,'geometry');
path(path,'inertia');
path(path,'masses');

epsilon = 10^-15;

fprintf('********** UNIT TESTS ***********\n');

%% Geometry
fprintf('Checking Geometry.............');

r = 0.05;
l = 2*r;
d = r;

% Gamma1
theta = 0*pi/180;
assert(gamma1(r,l,theta)==45*pi/180);

theta = 90*pi/180;
assert(abs(gamma1(r,l,theta)) < epsilon);

theta = -90*pi/180;
assert(gamma1(r,l,theta)==90*pi/180);

% Gamma2
theta = 0;
assert(gamma2(r,l,theta)==45*pi/180);

theta = -90*pi/180;
assert(gamma2(r,l,theta)==90*pi/180);

% x1
theta = 0;
assert(abs(x1(r,l,theta)-r*sqrt(2)) < epsilon);

theta = 90*pi/180;
assert(x1(r,l,theta)==2*r);

theta = -90*pi/180;
assert(abs(x1(r,l,theta)) < epsilon);

% x2
theta = 0;
assert(abs(x2(r,l,theta)-r*sqrt(2)) < epsilon);

theta = 90*pi/180;
assert(abs(x2(r,l,theta)) < epsilon);

theta = -90*pi/180;
assert(x2(r,l,theta)==2*r);

% AA'
theta = 0*pi/180;
assert(abs(normAA(l,d,theta) - d) < epsilon);

theta = 90*pi/180;
assert(abs(normAA(l,d,theta) - d) < epsilon);

theta = 45*pi/180;
assert(abs(normAA(l,d,theta) - (d*sqrt(2)-d)) < epsilon);

% BB'
theta = 0*pi/180;
assert(abs(normBB(l,d,theta) - d) < epsilon);

theta = 90*pi/180;
assert(abs(normBB(l,d,theta) - d*sqrt(5)) < epsilon);

theta = 45*pi/180;
assert(abs(normBB(l,d,theta) - d*sqrt(3)) < epsilon);
fprintf('[OK]\n');

%% Inertia
fprintf('Checking Inertia..............');

mD = 0.3;
R = 0.05;
Rint = 0.005;
H = 0.01;

% Ixx
assert(Ixx(mD,R,Rint) == mD/2*(R^2+Rint^2));
% Iyy
assert(Iyy(mD,R,Rint,H) == mD/4*(R^2+Rint^2+H^2/3));
% Izz
assert(Izz(mD,R,Rint,H) == mD/4*(R^2+Rint^2+H^2/3));

fprintf('[OK]\n');
fprintf('************ SUCCESS *************\n');