namespace :g do
  task :gift_codes => :environment do
    50.times do
      GiftCode.create(code: GiftCode::generate, good_id: Good::sample.id)
      puts "Generate success\n"
    end
  end
end
