% Function for the moment applied to the gyroscope wheel
% INPUT :
% r : radius of outer cylinder
% l : width of support
% d : height of dampers attach
% k : springs constant
% c : dampers constant
% theta : angle of the support
% OUTPUT :
% M : the moment along axis orthogonal to wheel axis

function M = momentZ(r, l, d, k, c, theta, thetadot)
    M = k*l/2*(-(x1(r,l,theta)-x1(r,l,0))*sin(gamma1(r,l,theta)) + (x2(r,l,theta)-x2(r,l,0))*cos(gamma2(r,l,theta)))...
        + (l^2*c/4*(1-cos(theta))*sin(theta) + l*c/2*(d-l/2*sin(theta))*cos(theta))*(x1dot(l,d,theta,thetadot)/normAA(l,d,theta) + x2dot(l,d,theta,thetadot)/normBB(l,d,theta));
end