function qddot = ropeModelSolver(args, q, qdot)
    S = args.S;
    damping_coeff = args.damping_coeff;
%     S_ = subs(S, [args.q_s; args.qdot_s], [q; qdot]);
%     damping_coeff = [ones(1, args.num_segs) * args.damping_coeff, zeros(1, args.num_segs)];
%     [A, b] = equationsToMatrix(S == damping_coeff .* qdot, args.qddot_s);
%     A = subs(A, [args.q_s; args.qdot_s], [q; qdot]);
%     b = subs(b, [args.q_s; args.qdot_s], [q; qdot]);
%     qddot = double(A\b)';
    damping_coeff = [ones(1, args.num_segs) * args.damping_coeff, ones(1, args.num_segs) * args.damping_coeff_spring, 0, 0];
    S = subs(S,[args.q_s; args.qdot_s], [q; qdot]);
    damping_coeff = subs(damping_coeff,[args.q_s; args.qdot_s], [q; qdot]);
%     args.qddot_s
%     qddot = zeros(1,args.num_segs);
%     [q1,q2,q3,q4,q5,q6,q7,q8,q9,q10] = vpasolve(S == damping_coeff .* qdot, args.qddot_s);
        soln = vpasolve(S == damping_coeff .* qdot, args.qddot_s);
        qddot = double(vpa(struct2cell(soln)))';
%         qddot = 
%         qddot = [];
%     qddot =  [q1,q2,q3,q4,q5,q6,q7,q8,q9,q10];
end