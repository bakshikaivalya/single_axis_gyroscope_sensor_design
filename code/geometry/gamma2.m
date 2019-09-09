function gamma = gamma2(r,l,theta)
    gamma = atan(l/2*cos(theta)/(r-l/2*sin(theta))) - theta;
end