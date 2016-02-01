namespace :my_namespace do
  desc "Generates Topics using Nokogiri to scrape r/cfb"
  task generate_content: :environment do
    puts "starting task.."
    Topic.generate()
    puts "finishing task.."
  end

end
