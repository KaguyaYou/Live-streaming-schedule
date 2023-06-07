class VtuberComment < ApplicationRecord
   
  t.text :comment
  t.integer :user_id
  t.integer :vtuber_id
  
end
