require 'net/http'

module Meetup
  class MembersCount
    def self.total
      new.total
    end

    def initialize
      @key = ENV['MEETUP_KEY']
    end

    def members_count
      REDIS.get('meetup_members')
    end

    def get_meetup_members
      puts "get_meetup_members"
      json = ::Net::HTTP.get(URI("https://api.meetup.com/parisrb?format=json&key=#{@key}"))
      parisrb = JSON.parse(json)
      REDIS.set('meetup_members', parisrb['members'])
      REDIS.expire('meetup_members', 24.hours)
      members_count
    end


    def total
      get_meetup_members
    end

    def get_next_meetup
     
    end


  end

   
  


end
