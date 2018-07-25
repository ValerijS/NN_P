function [tr_duration,  w_start_time] = duration_cell(trainning_table, work_table)
    z_t_t = size(trainning_table);
    z_w_t = size(work_table);
    Tr = trainning_table.Properties.VariableNames;   
    a_logic = strcmpi(Tr, {'Opened'});
    b_logic = strcmpi(Tr, {'Changed'});
    for i = 1: z_t_t(2)
        if a_logic(i)
            start_time = i;
        end
        if b_logic(i)
            finish_time = i;
        end
    end
    tr_duration = cell(1,z_t_t(1));
    w_start_time = cell(1,z_w_t(1));
    for k = 1 : z_t_t(1)
        tr_duration{1,k} = [trainning_table{k, start_time}, trainning_table{k,finish_time}];
    end  
    for k = 1 : z_w_t(1)
        w_start_time{1,k} = {work_table{k,  start_time}};
    end  
end

