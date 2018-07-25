function [ input] = create_data_for_work_use_table_index( table, index)
    table = table2cell(table);
    z_t = size(table);      
    col_index = cell(1);
    for j = 1 : z_t(2)
        col_index = [col_index, index{1,j}(1,:)];
     end
     z_c_i = size(col_index);
     input = zeros(z_c_i(2)-1,1);
     index_size = z_c_i(2)-1;
     for i = 1 : z_t(1)
         input_col = [];         
        for j = 1 : z_t(2)
            z = size(index{1,j});
            input_j = zeros(z(2),1);
            for k = 1 : z(2)                                
                    if strcmp(index{1,j}{1,k}, table{i,j})
                        input_j(k,1) = 1; 
                        break
                    end
            end
           input_col = [input_col; input_j];           
        end
        %size(input_col)
        input = [input, input_col];        
     end
     input(:,1) = [];
end 
   
  






