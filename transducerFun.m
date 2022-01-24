function r = transducerFun(c,param,cx)
p = param.p;
q = param.q;
z = param.z;
a = param.a;
b = param.b;
if ~exist('cx','var'); cx = 0; end
r = (c.^p).*(1+a.*cx) ./ ( z + (c.^q).*(1+b.*cx) );
