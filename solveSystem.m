function confs = solveSystem(args, initConf, systemModelSolver)
    timeStamp = args.timeStamp
    t_len = len(args.timeStamp)
    
    q = initConf.q
    qdot = initConf.qdot
    qddot = systemModelSolver(q, qdot)
    confs = [q, qdot, qddot]
    
    for idx = 2:t_len
        time = timeStamp(idx)
        dt = timeStamp(idx) - timeStamp(idx - 1)
        
        q = q + qdot .* dt + 0.5 .* qddot .* dt.^2
        qdot = qdot + qddot .* dt
        qddot = systemModelSolver(q, qdot)
        
        confs = [confs; [q, qdot, qddot]]
    end
end