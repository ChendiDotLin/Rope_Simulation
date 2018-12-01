clear all
close all


args.num_segs = 3;

args.damping_coeff = 0.2;
args.g = 9.8;
args.seg_length = ones(1, args.num_segs) * 1;
args.timeStamp = 0:0.02:5;
args.m = 0.01;
args.k_l = 0.01;



initConf.q = [ones(1, args.num_segs) * 0, 1 * args.seg_length];
initConf.qdot = [ones(1, args.num_segs) * 0, 0 *args.seg_length];

[args.S, args.q_s, args.qdot_s, args.qddot_s] = setup(args);


confs = solveSystem(args, initConf, @ropeModelSolver);
visualize(args, confs)


