function norm2 = normBB(l, d, theta)
    norm2 = norm([-l/2*(1-cos(theta));d+l/2*sin(theta)],2);
end