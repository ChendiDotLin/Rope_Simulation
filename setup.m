function [] = setup(params)
    num_seg = params.num_segs;
    g = params.g;
    l = params.seg_length;

    q = sym('q',[1,num_seg]); % theta 
    qdot = sym('qdot',[1,num_seg]); % theta dot 
    x = sym('x',[1,num_seg]); % theta 
    y = sym('y',[1,num_seg]); % theta dot 
    x(1) = l(1)*cos(q(1));
    y(1) = l(1)*sin(q(1));

    for i = 2: num_seg

       x(i) = x(i-1) + l(i)*cos(q(i));
       y(i) = y(i-1) + l(i)*sin(q(i));
    end

    vx = jacobian(x,q).*qdot;
    vy = jacobian(y,q).*qdot;

    v = [vx,vy];
    T = 0.5 * v * v';
    U = sum(g * y);

    L = T - U;





end