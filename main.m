clear all
close all


args.num_segs = 10;

args.damping_coeff = 0.5;
args.damping_coeff_spring = 0.5;
args.g = 9.8;
args.seg_length = ones(1, args.num_segs) * 1;
args.fixed_endpoint = true;
args.timeStamp = 0:0.001:10;
args.m = 1;
args.k_l = 500;


initConf.q = [ones(1, args.num_segs) * 0, 1 * args.seg_length, 0, 0];
initConf.qdot = [ones(1, args.num_segs) * 0, 0 *args.seg_length, 0, 0];

[args.S, args.q_s, args.qdot_s, args.qddot_s] = setup(args);


confs = solveSystem(args, initConf, @ropeModelSolver);
visualize(args, confs)


