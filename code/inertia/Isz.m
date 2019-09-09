function I = Isz(m1, m2, m3, l, e, h, Rint)
    I = m1*(l^2/6 + h^2/6) + m2*(h^2/6 + e^2/6 + (l-e)^2/2) + m3*(Rint^2/4 + (l-e)^2/12);
end