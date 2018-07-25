function [P, y, T_r, ind_t, V, W,d] = run_patternnet_e_5_1_1_20_07(P,input,time_int,deep_of_search, timer )
    net = P{7};   
    y = net(input);   
    z_i = size(input);
        
    V = zeros(1,z_i(2));
    W = zeros(1,z_i(2));
    C = cell(1,z_i(2));   
 for i = 1 : z_i(2)
 [ ~, ind_t] = max(y(:,i));  % dim y > 1 ///  
 if ~isempty(P{1})
% z_P1_i = size(P{1});
 %i_P1 = i_P1 + 1;
 P{1}{i,timer} = ind_t;
 else
  P{1}{i,1} = ind_t;   
 end
 %z_ind = size(P{1}(2));
 s_ind = 1/2;
% if z_ind > 0
if ~isempty(P{1})
     z_ind = size(P{1});
 for k = 1 : z_ind(2)
     if isfloat(P{1}{i,k}) && ~isempty(P{1}{i,k})       
     s_ind = s_ind + (1/time_int)^(k+1) * (-1)^P{1}{i,k};
     else     
     end
 end
end
 s_ind  = s_ind * P{3};       
 t_w =  P{11}{1, i};
 d = days(datetime('now') - t_w{1}); 
 [ ~, ind_t] = max(y(1,i));
 V(1,i) =  s_ind;
 W(1,i) = V(1,i) - d;
 z_P_i = size(P{1});
 if z_P_i(2) <= 3
    formatOut = 'yyyy';
   % result = datestr(now +  W, formatOut);
    C{1,i} = datestr(now +  W, formatOut);
 elseif  z_P_i <=  7 
    formatOut = 'mmm yyyy';
    %result = datestr(now +  W, formatOut);
    C{1,i} = datestr(now +  W, formatOut);
 else
    formatOut = 'dd mmm yyyy';
   % result = datestr(now +  W, formatOut);
    C{1,i} = datestr(now +  W, formatOut);
 end   
 end 
    T_r = cell2table(C);
    P{8} = T_r;
    % writetable(T_r, 'result.csv');
end