atom_feed(:tag_uri => "2009") do |feed|
  feed.title("gradmx")
  feed.subtitle("Latest events")
  feed.updated(@events.first ? @events.first.created_at : Time.now.utc)

  for event in @events
    feed.entry(event) do |entry|
      entry.title(event.title)
      entry.content(render(:partial => 'events/feed_entry',
                           :locals => { :event => event }),
                    :type => 'html')
      entry.author do |author|
        author.name(event.user.login)
        author.uri(user_url(event.user))
      end
    end
  end
end
