function[] = visualize(args, confs)
figure()
num_segs = args.num_segs;
l = args.seg_length;
q = confs(:,1:num_segs);
steps = size(q,1);
for time = 1:steps
    x = zeros(1,num_segs);
    y = zeros(1,num_segs);
    x(1) = l(1)*cos(q(time,1));
    y(1) = l(1)*sin(q(time,1));
    for i = 2: num_segs
        
        x(i) = x(i-1) + l(i)*cos(q(time,i));
        y(i) = y(i-1) + l(i)*sin(q(time,i));
    end
    x = [0,x];
    y = [0,y];
    plot(x,y,'b','LineWidth',2);
    hold off
    xlim([-1,1]);
    ylim([-2,0]);
    %     hold on
    %     drawnow()
    %     hold on
    pause(0.1)
    M(i) = getframe(gcf);
    
end
movie(M,1)
VideoWriter(M,'rope_simulation.avi')
