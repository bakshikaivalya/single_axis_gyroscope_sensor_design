function zdot = projfuncLin( t, z )

% Get global variables for design
% Linear mode
global C
global Ixx
global Izz
global K
global omega

global tData
global qData

% Interpolation of the input data to fit with simulation time step
q = interp1(tData, qData, t);
% State update
zdot(1,1) = z(2);
% Linearized moment
zdot(2,1) = momentLin(z, K, C)/Izz + Ixx*omega*q/Izz;
end

