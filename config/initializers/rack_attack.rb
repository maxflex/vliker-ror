if Rails.env.production?
  # Throttle requests to 5 requests per second per ip
  Rack::Attack.throttle('req/ip', :limit => 4, :period => 1.second) do |req|
    # If the return value is truthy, the cache key for the return value
    # is incremented and compared with the limit. In this case:
    #   "rack::attack:#{Time.now.to_i/1.second}:req/ip:#{req.ip}"
    # If falsy, the cache key is neither incremented nor checked.

    # do count assets as a request
    if req.path.include?('assets')
        next
    end
    req.ip
  end

  # Throttle get new tasks
  Rack::Attack.throttle('get_new_tasks/ip', :limit => 10, :period => 5.second) do |req|
    if req.post? && req.path == '/get_new'
      req.ip
    end
  end
end
