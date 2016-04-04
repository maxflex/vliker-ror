json.tasks @tasks do |task|
  json.(task, :likes, :need, :active, :reports, :url, :queue)
end
