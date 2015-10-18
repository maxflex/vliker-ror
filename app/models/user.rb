class User < ActiveRecord::Base
  has_many :tasks

  require 'digest'

  SALT = '32dg9823dldfg2o001-2134>?erj&*(&(*^'

  # If ID needed, save user to DB
  def get_id
    if self.new_record?
      self.save
      self.to_cookie
    end
    return self.id
  end

  def to_cookie
    cookies[:vtoken] = self.token = Digest::MD5::hexdigest(SALT + self.get_id + SALT)
  end
end
