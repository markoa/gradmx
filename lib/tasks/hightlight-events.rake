
namespace :events do
  desc 'Stores 10 interesting (actually random) events in a Tokyo Cabinet'
  task :highlight => :environment do
    events = Event.upcoming
    chosen = []
    count = events.size
    while !(chosen.size == 10)
      e = events[rand(count)]
      chosen << e unless chosen.include?(e)
    end
    
    today = Time.now.to_date.to_s
    for e in chosen
      key = Highlights.new_key_for_prefix("event")
      Highlights.table[key] = { 'id' => e.id.to_s, 'saved_on' => today }
    end
  end
end
