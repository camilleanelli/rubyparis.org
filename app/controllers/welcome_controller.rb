require 'meetup/members_count'
require 'net/http'

class WelcomeController < ApplicationController


  layout "welcome"
  
  expose(:members_count) { Meetup::MembersCount.total }

  
  expose(:toto) {
  puts "toto"
  	 json = ::Net::HTTP.get(URI("https://api.meetup.com/parisrb?format=json&key=#{ENV['MEETUP_KEY']}"))
      parisrb = JSON.parse(json)
      # puts parisrb.inspect
      @id_next_event = parisrb['next_event']['id']
        puts @id_next_event
        json_next_event = ::Net::HTTP.get(URI("https://api.meetup.com/parisrb/events/#{@id_next_event}?format=json&key=#{ENV['MEETUP_KEY']}"))
        toto = JSON.parse(json_next_event)
        puts toto.inspect
        @date = DateTime.strptime(toto['time'].to_s[0..-4],'%s' )
        puts @date
        puts toto['venue']['name']
        puts toto['venue']['address_1']
       	puts toto['venue']['address2']
        # hash[date] = toto['time']

        # @date = toto['time']
       
        # @link = toto['link']
  }
  expose(:sponsors) { Sponsor.visible }
  expose(:job_offers) { JobOffer.all }
  expose(:tweets) { Tweet.all }
end
