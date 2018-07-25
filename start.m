%t - trainning; w - working

%tr_table_original = readtable('data_for_training.csv');
%w_table_original = readtable('data_for_work1.csv');

tr_table_original = table_bugs_29_06_100; 
w_table_original1 = table_bugs_29_06_100_one; %table_work_one; %table_bugs_29_06_100_one; %table_work_one; %table_bugs_29_06_100_one;% data_for_test_onetickets; %

% starting setting
mode = "new"; % "stable", "new" or "exp"
save_in_file = 'stat_inf';
predict_period = 1024;
min_trulity_level = 0.5;
predict = '';
step_repeat = 15;
deep_of_search = 9;
deep_of_check = 9; % not more than deep_of_search = 5
Result = {};
loop_repeats_quant = 10;
layers_quant = 10;
low_limit_for_trainning = 500;
time_int = 2;

z_w_t_o = size(w_table_original1);

if mode == "stable"
    load(save_in_file)
elseif mode == "new"
    res_opt_new = -1;
else     
end
for t = 1 : z_w_t_o(1)
    t
    w_table_original = w_table_original1(t,:);   
    list_of_valeus_by_steps = cell(1,step_repeat); %  the starting setting for values of predict which are got by repetitions and steps of searching 
    for s = 1 : step_repeat    
        repetition_of_step = s
        [tr_duration, w_start_time] = duration_cell(tr_table_original, w_table_original);
        table = table2cell(tr_table_original);
        [index, modif_table, w_modif_table] = create_index_of_keywords(table, 60,[], w_table_original);
        [input_w] = create_data_for_work_input( w_modif_table, index);    
        %ind_  = cell(2,z_w_t_o(1));
        P = {{}, modif_table, predict_period, cell(1,6)}; % cell with all information
        P{10} = tr_duration;
        P{11} = w_start_time;
        [ P, y, T_r , y1, timer, V, d] = main( P, 2, save_in_file, 5, 10, index, input_w, 500, 0, deep_of_search, mode,res_opt_new );
        list_of_valeus_by_steps{1,s} = P{9};  % values of predict which are got by repetitions and steps of searching     
    end
        h_lim = 1;
        M = 0;
        for h = 1 : deep_of_check
        list_of_valeus_by_steps_1 = {};
        z_l_v_s  = size(list_of_valeus_by_steps);
        group_2 = {};
        group_3 = [];
        group_ = [];
        z_g_2 = size(group_2);          
        group_1 = [];
     for v = 1 : z_l_v_s(2)
         group_1 = [v];            
     for v1 = 1 : z_l_v_s(2)
         z_l_v_b_s_v  = size(list_of_valeus_by_steps{v});
         z_l_v_b_s_v1 = size(list_of_valeus_by_steps{v1});
        if  h < z_l_v_b_s_v(2) && h < z_l_v_b_s_v1(2) &&  list_of_valeus_by_steps{v}{h} == list_of_valeus_by_steps{v1}{h}    
            group_1  = [group_1, v1];
        end             
     end
        group_2{z_g_2(2) + 1} = group_1;
        z_g_2 = size(group_2);                            
     end
        z_g_2 = size(group_2);    
        for g = 1 : z_g_2(2)
            z_g_2_g = size( group_2{g});
            group_3(1,g) = z_g_2_g(2);
        end
        [M,I] = max( group_3);
        if M > min_trulity_level * step_repeat
            h_lim = h; % level of depth, which is reached by current search
            trulity_level = min([M/step_repeat, 0.97]);
        end
        group_ = group_2{I}
        z_g_ =size(group_);
        for v = 1 :  z_g_(2)
           list_of_valeus_by_steps_1(v) =  list_of_valeus_by_steps(group_(v));
        end
        list_of_valeus_by_steps = list_of_valeus_by_steps_1;
        z_l_v_s  = size(list_of_valeus_by_steps);
        end
        % h_lim - level of depth, which is reached by current search
        V_res = list_of_valeus_by_steps_1{1}{h_lim};
        W = V - d;
        if h_lim <= 3
            formatOut = 'yyyy';
            result = datestr(now +  W, formatOut);
            beginning =  datestr(now +  W - 0.5^(h_lim +1) * predict_period, formatOut);
            ending = datestr(now +  W + 0.5^(h_lim +1) * predict_period, formatOut);
            predict = ['from ', beginning, ' till ', ending];
            %C = datestr(now +  W, formatOut);
        elseif  h_lim <=  7 
            formatOut = 'mmm yyyy';
            result = datestr(now +  W, formatOut);
            beginning =  datestr(now +  W - 0.5^(h_lim +1) * predict_period, formatOut);
            ending = datestr(now +  W + 0.5^(h_lim +1) * predict_period, formatOut);
            predict = [ beginning, ' till ', ending];
            %C{1,i} = datestr(now +  W, formatOut);
        else
            formatOut = 'dd mmm yyyy';
            result = datestr(now +  W, formatOut);            
            beginning =  datestr(now +  W - 0.5^(h_lim +1) * predict_period, formatOut);
            ending = datestr(now +  W + 0.5^(h_lim +1) * predict_period, formatOut);
            predict = ['from ', beginning, ' till ', ending];
            
           % C{1,i} = datestr(now +  W, formatOut);
        end                
        Result{t} = {predict, trulity_level, h_lim};
end
