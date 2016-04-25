json.tasks @tasks do |task|
  json.(task, :likes, :need, :active, :reports, :url, :queue, :priority)
end

json.orders @orders do |order|
  json.(order, :link, :done, :external_done, :external_need, :review)

  json.good do
    json.count order.good.count
    json.good_type do
      json.title order.good.good_type.title
    end
  end
end
