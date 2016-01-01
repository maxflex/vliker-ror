class Notification

  # count notifications
  def self.count(user_id)
    if !user_id.nil?
      Task.where(user_id: user_id, active: true).count + Order.where(user_id: user_id, done: false).count
    end
  end

end
