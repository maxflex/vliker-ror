class Good < ActiveRecord::Base
  # belongs_to :good_type, :class_name => 'GoodType', :foreign_key => 'good_types_id'
  belongs_to :good_type
end
