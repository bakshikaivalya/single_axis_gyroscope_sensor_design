function zdot = projfunc( t, z )

% Get global variables for design
% Linear mode
global Ixx
global Izz
global omega
% Non linear
global k
global l
global r
global d
global c

global tData
global pData
global qData
global rData


% Interpolation of the input data to fit with simulation time step
q = interp1(tData, qData, t);

% State update
zdot(1,1) = z(2);
% Complete moment expression
zdot(2,1) = moment(z, k,l,r, d,c)/Izz + Ixx*omega*q/Izz;

end

