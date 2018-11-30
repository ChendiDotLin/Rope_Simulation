function qqdot = ropeModelSolver(args, q, qdot)
    S = args.S;
    damping_coeff = args.damping_coeff;
%     S_ = subs(S, [args.q_s; args.qdot_s], [q; qdot]);
    damping_coeff = [ones(1, args.num_segs) * args.damping_coeff, zeros(1, args.num_segs)];
    [A, b] = equationsToMatrix(S == damping_coeff .* qdot, args.qddot_s);
    A = subs(A, [args.q_s; args.qdot_s], [q; qdot]);
    b = subs(b, [args.q_s; args.qdot_s], [q; qdot]);
    qqdot = double(A\b)';
    
end