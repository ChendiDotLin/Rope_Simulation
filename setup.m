function [S, q, qdot, qddot] = setup(params)
    num_seg = params.num_segs;
    g = params.g;
    l = params.seg_length;
    m = params.m;
    q = sym('q',[1,num_seg * 2 + 2]); % theta
    qdot = sym('qdot',[1,num_seg * 2 + 2]); % theta dot 
    
    

    if ~params.fixed_endpoint
        x = sym('x',[1,num_seg + 1]); % theta 
        y = sym('y',[1,num_seg + 1]); % theta dot
        x(end) = q(end - 1)
        y(end) = q(end)
        x(1) = q(num_seg + 1)*cos(q(1)) + x(end);
        y(1) = q(num_seg + 1)*sin(q(1)) + y(end);
    else
        x = sym('x',[1,num_seg]); % theta 
        y = sym('y',[1,num_seg]); % theta dot
        x(1) = q(num_seg + 1)*cos(q(1)) + 0;
        y(1) = q(num_seg + 1)*sin(q(1)) + 0;
    end
    for i = 2: num_seg

       x(i) = x(i-1) + q(num_seg + i)*cos(q(i));
       y(i) = y(i-1) + q(num_seg + i)*sin(q(i));
    end

    vx = jacobian(x,q) * qdot.';
    vy = jacobian(y,q) * qdot.';

    T = 0.5 * sum(vx.'.^2 + vy.'.^2) * m;
    U = sum(g * y) * m + sum(0.5 * params.k_l * (q(num_seg+1: 2*num_seg)-l).^2);

    L = (T - U) * 100;
    
 
[S, qddot] = ELE(L, q, qdot);
end