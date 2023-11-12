function [as] = AS(v)
%[as] = AS(v) return anti-symetric matrice of vector v
as = [0       -v(end)   v(end-1);
      v(end)   0       -v(1)    ;
     -v(end-1) v(1)     0       ];
end

