function I = Isy(m1, m2, m3, l, e, L, Rint)
    I = m1*(l^2/6 + e^2/6 + (L-e)^2/2) + m2*(e^2/6 + L^2/6 + (l-e)^2/2) + m3*(Rint^2/4 + (l-e)^2/12);
end