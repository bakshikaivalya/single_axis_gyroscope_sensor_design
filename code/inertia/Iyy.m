function I = Iyy(mD, R, Rint, H)
    I = mD/4*(R^2 + Rint^2 + H^2/3);
end