function [S, q, qdot, qddot] = setup(params)
    num_seg = params.num_segs;
    g = params.g;
    l = params.seg_length;

    q = sym('q',[1,num_seg * 2]); % theta
    qdot = sym('qdot',[1,num_seg * 2]); % theta dot 
    

    
    x = sym('x',[1,num_seg]); % theta 
    y = sym('y',[1,num_seg]); % theta dot 
    x(1) = q(num_seg + 1)*cos(q(1));
    y(1) = q(num_seg + 1)*sin(q(1));

    for i = 2: num_seg

       x(i) = x(i-1) + q(num_seg + i)*cos(q(i));
       y(i) = y(i-1) + q(num_seg + i)*sin(q(i));
    end

    vx = jacobian(x,q) * qdot';
    vy = jacobian(y,q) * qdot';

    v = [vx;vy]';
    T = 0.5 * v * v';
    U = sum(g * y) + sum(0.5 * params.k_l * (q(num_seg+1: 2*num_seg)-l).^2);

    L = T - U;
    
    [S, qddot] = ELE(L, q, qdot);
end