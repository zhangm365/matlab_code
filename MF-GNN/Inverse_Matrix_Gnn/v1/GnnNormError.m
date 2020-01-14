function GnnNormError(gamma)
if nargin<1, gamma=1; end
total=8; n=size(MatrixA,1);
for i=1:total
    x0=4*(rand(n^2,1)-0.5*ones(n^2,1));
    NormError(x0,gamma);
end
text(2.4,2.2,['gamma=' int2str(gamma)]);