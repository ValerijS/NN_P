
function[P, work_net, res, mi,list_res, q, q_sum,y,target] = create_work_patternnet(P, input, target, loop_repeats_quant, layers_quant) 
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    z = size(target);    
    mi = z(2) * z(1);
    q = zeros(loop_repeats_quant, z(2));
    q_sum = zeros(1,loop_repeats_quant);
    res = 0 - 1;
    list_res = zeros(1,loop_repeats_quant);    
    for i = 1 : loop_repeats_quant    
        i
        net = patternnet(layers_quant);
        net = train(net,input,target);
        y = net(input);
        sum = 0 ;
        for j = 1 : z(2)
            [M, I] = max(y(:,j));
            if(target(I,j) == 1)
                list_res(1,i) = list_res(1,i) + 1/z(2);
            end
            for k = 1 : z(1)            
                if(target(k,j) == 1)
                     q(i,j) =  (1 - y(k,j)) * (1 - y(k,j)) ; 
                     sum = sum + (1 - y(k,j)) * (1 - y(k,j));
                end
            end
        end
        q_sum(1,i) = sum;
        if(list_res(1,i) > res)
            res = list_res(1,i);
            work_net = net;        
        end
        P{7} = work_net;
        P{8} = res;
    end
end