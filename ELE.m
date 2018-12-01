function [S, qddot] = ELE (L,q,qdot)
    dL_dq = jacobian(L,q);
    dL_dqdot =  jacobian(L,qdot);
    syms t
    fq = sym('a',size(q));
    for i = 1:length(q)
        fq(i) = symfun(sprintf('fq%d(t)', i), t);
    end
    fqdot = diff(fq,t);
    fqddot = diff(fqdot,t);
    dL_dqdot = subs(dL_dqdot,[q;qdot],[fq;fqdot]);
    S = dL_dq - diff(dL_dqdot,t);
    qddot = sym('qddot',size(q));
    
    S = subs(S,[fq;fqdot;fqddot],[q;qdot;qddot]);
    S = simplify(S);
    
end