function[] = visualize(args, confs)
figure()
num_segs = args.num_segs;
l = args.seg_length;
q = confs;
steps = size(q,1);
for time = 1:steps
    x = zeros(1,num_segs);
    y = zeros(1,num_segs);
    x(1) = q(time,num_segs+1)*cos(q(time,1))+q(time,num_segs*2+1);
    y(1) = q(time,num_segs+1)*sin(q(time,1))+q(time,num_segs*2+2);
    for i = 2: num_segs
        x(i) = x(i-1) + q(time,num_segs+i)*cos(q(time,i));
        y(i) = y(i-1) + q(time,num_segs+i)*sin(q(time,i));
    end
    x = [q(time,num_segs*2+1),x];
    y = [q(time,num_segs*2+2),y];
    plot(x,y,'b','LineWidth',2);
    hold off
    xlim([-1*num_segs,1*num_segs]);
    ylim([-2*num_segs,0]);
    %     hold on
    %     drawnow()
    %     hold on
%     pause(0.01)
    M(time) = getframe(gcf);
    
end

% movie(M,1);
v = VideoWriter('rope_simulation.avi');
open(v);
writeVideo(v,M);
close(v);

