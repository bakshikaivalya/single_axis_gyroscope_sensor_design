% Function for the dynamic model equation of the gyroscope
% INPUT :
% R : external radius of wheel
% H : thickness of wheel
% mD : mass of wheel
% l : width of support
% h : height of rectangles composing support
% e : thickness of rectangles composing support
% L : length of support
% Rint : inner radius of wheel
% m1 : mass of one small rectangle composing support
% m2 : mass of one big rectangle composing support
% m3 : mass of cylinder to support wheel
% k : springs constant
% c : dampers constant
% d : height of dampers attach
% Omega : input rotation speed
% theta : angle of the support
%
% OUTPUT :
% Eq : the equation of motion support axis such that Eq = thetadotdot

function Eq = dynamicModel(R, r, H, mD, l, h, e,L, Rint, m1, m2, m3, k, c, d, omega, OMEGA, theta, thetadot)
    Eq = 1/(Izz(mD,R,Rint,H)+Isz(m1,m2,m3,l,e,h,Rint))*(momentZ(r,l,d,k,c,theta,thetadot)+...
        Ixx(mD,R,Rint)*omega*OMEGA*cos(theta)-...
        (Iyy(mD,R,Rint,H)+Isy(m1,m2,m3,l,e,L,Rint)-(Ixx(mD,R,Rint)+Isx(m1,m2,m3,h,e,L,Rint)))*OMEGA^2*sin(theta)*cos(theta));
end