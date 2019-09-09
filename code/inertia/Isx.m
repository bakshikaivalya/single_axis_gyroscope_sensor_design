function I = Isx(m1, m2, m3, h, e, L, Rint)
    I = m1*(h^2/6 + e^2/6 + (L-e)^2/2) + m2*(h^2/6 + L^2/6) + m3*Rint^2/2;
end