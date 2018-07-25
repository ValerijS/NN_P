function [words_rating, modif_table, w_modif_table] = create_index_of_keywords_m(original_table, max_quantity_of_words, clear_array,w_modif_table)
%UNTITLED20 Summary of this function goes here
%   Dfid = fopen(path_to_input_file);
z_c_a = size(clear_array);
e = z_c_a(2);
for i = 0 : e-1
    original_table(:,clear_array(1,e - i)) = [];
    w_modif_table(:,clear_array(1,e - i)) = [];
end
modif_table = original_table;
table = table2cell(original_table);
z_t = size(table);
words_rating = cell(1, z_t(2));
for j = 1 : z_t(2)
   words_rating{1,j} = cell(2);
   z = size(words_rating{1,j});
   for i = 1 : z_t(1)
   ind = 0;        
        for k = 1:z(2)                
            if strcmp(words_rating{1,j}{1, k}, table{i,j})            
            words_rating{1,j}{2 ,k} = words_rating{1,j}{2,k} + 1;
            ind = 1;
            break;
            end                
        end 
        if ind == 0
                words_rating{1,j}{1, z(2) + 1} = table{i,j};
                words_rating{1,j}{2, z(2) + 1} = 1;
                z = size(words_rating{1,j});
        end            
    end
        words_rating{1,j}(:,1) = [];
        words_rating{1,j}(:,1) = [];
        z = size(words_rating{1,j});            
        if (z(2) > 0.5 *  z_t(1) || z(2) == 1)           
            for m = 1 : z_t(1)
                if iscell(table{m,j})
                    A = isspace(table{m,j}{1,1});                    
                else
                    A = isspace(table{m,j});
                end
                z_A = size(A);                    
                start = 0;
                for n = 1 : z_A(2)                      
                    if A(n) ||n == z_A(2)                            
                       start = start + 1;                           
                       if iscell(table{m,j})
                           token = table{m,j}{1.1}(1,start : n - 1);
                       else
                       token = table{m,j}(1,start : n - 1);
                       end
                           start = n;                       
                           ind = 0;                             
                           for k1 = 1:z(2)                
                                if strcmp(words_rating{1,j}{1, k1}, token)            
                                    words_rating{1,j}{2 ,k1} = words_rating{1,j}{2,k1} + 1;
                                    ind = 1;
                                    break;
                                end
                            end 
                            if ind == 0
                                    words_rating{1,j}{1, z(2) + 1} = token;
                                    words_rating{1,j}{2, z(2) + 1} = 1;
                                    z = size(words_rating{1,j});
                            end
                    end                        
                end                    
            end
                z__w_r_j =size(words_rating{1,j});
                if z__w_r_j(2) > 1
                    words_rating{1,j}(:,1) = [];                    
                end
        end
end              
z_m_t = size(modif_table); 
for j = 1 : z_m_t(2)
    z = size(words_rating{1,j});
    for i = 1 : z(2)
            for k = i : z(2)
                if words_rating{1,j}{2, k} > words_rating{1,j}{2, i}
                   var1 = words_rating{1,j}{1, k};
                   var2 = words_rating{1,j}{2, k};
                   words_rating{1,j}{1, k} = words_rating{1,j}{1, i};
                   words_rating{1,j}{2, k} = words_rating{1,j}{2, i};
                   words_rating{1,j}{1, i} = var1;
                   words_rating{1,j}{2, i} = var2;
                end
            end
    end
end
for j = 1 : z_m_t(2)
    z = size(words_rating{1,j});
        words_rating{1,j} = words_rating{1,j}(:, 1 :  min(z(2), max_quantity_of_words));
end
end