class Order < ActiveRecord::Base
  belongs_to :good
  belongs_to :user

  before_save :place_external_order

  def place_external_order
    
  end
end
