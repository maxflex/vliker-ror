class GiftCode < ActiveRecord::Base
  belongs_to :good
  belongs_to :user

  def self.generate
    str = [('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
    string = (0...6).map { str[rand(str.length)] }.join
  end
end
