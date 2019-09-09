function gamma = gamma1(r,l,theta)
    gamma = pi/2 - theta - atan(l/2*cos(theta)/(r+l/2*sin(theta)));
end