function xd = x1dot(l, d, theta, thetadot)
    xd = thetadot*(l^2/2*sin(theta) - l*d*cos(theta))/(2*sqrt(l^2/4*(1-cos(theta))^2 + (d-l/2*sin(theta))^2));
end