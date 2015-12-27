class Good < ActiveRecord::Base
  # belongs_to :good_type, :class_name => 'GoodType', :foreign_key => 'good_types_id'
  include ActionView::Helpers::NumberHelper

  belongs_to :good_type

  def full_name
    "+#{number_with_delimiter(count)} #{good_type.title}"
  end

  def self.sample
    order('RANDOM()').first
  end
end
