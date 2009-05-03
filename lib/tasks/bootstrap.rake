
require 'faker'

namespace :db do
  desc 'Generates lots of fake data'
  task :bootstrap => :environment do

    # This array of country names is available in the country_select plugin
    countries = ActionView::Helpers::FormOptionsHelper::COUNTRIES

    Event.transaction do
      2.times do
        country = countries[rand(countries.size)]
        16.times do
          c = City.parse(Faker::Address::city, country)
          c.save!
        end
      end

      cities = City.all

      128.times do
        User.create(:login => Faker::Internet::user_name,
                    :name => Faker::Name::name,
                    :email => Faker::Internet::email,
                    :city_id => cities[rand(cities.size)].id,
                    :password => "1234rgba",
                    :password_confirmation => "1234rgba")
      end

      users = User.all

      256.times do
        Location.create(:name => Faker::Name::last_name,
                        :description => Faker::Lorem::paragraphs.join("\n"),
                        :city_id => cities[rand(cities.size)].id,
                        :user_id => users[rand(users.size)].id)
      end

      locations = Location.all

      1_024.times do |i|
        d = rand(60)+1
        Event.create(:title => Faker::Lorem::words(4).join(' '),
                     :description => Faker::Lorem::paragraphs.join("\n"),
                     :time_begin => d.days.from_now.utc,
                     :location_id => locations[rand(locations.size)].id,
                     :user_id => users[rand(users.size)].id)
      end
    end
  end
end
