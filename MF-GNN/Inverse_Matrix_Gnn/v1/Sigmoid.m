function output=Sigmoid(X,xi)
if nargin==1, xi=4; end
output=(1-exp(-xi*X))./(1+exp(-xi*X));