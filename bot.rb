require 'cinch'
require  'rspotify'
require 'sequel'
require_relative 'db'

  def reply_random(m,list)
    m.reply list.sample
  end

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.net"
    c.user = "holla_bot_girl"
    c.nick = "holla_bot_girl"
    c.channels = ["#alskdj"]
  end

  helpers do 
    def spotify_artists(artists)
      artist = RSpotify::Artist.search(artists).first
      if artist == nil
        "Sorry, I don't know that artist."
      else
        "#{artist.name}-#{artist.top_tracks(:US).first.name}: #{artist.top_tracks(:US).first.uri}"
      end
    end
  end
  
  on :message, /^!help$/ do |m|
    m.reply "Type !cute or cranky for pretty pictures."
    m.reply "Tell us about yourself. Type !me nickname, twitter, github."
    m.reply "Learn about others. Type !stalk nickname."
    m.reply "More help to come!"
  end

  on :message, /^!britney/ do |m|
    m.reply "britneywright made me"
  end

  on :message, /favorite song/ do |m|
    m.reply "My favorite song is Hollaback Girl http://www.youtube.com/watch?v=Kgjkth6BRRY"
  end

  on :message, /^!cute$/i do |m|
    reply_random m, [
    "http://justcuteanimals.com/wp-content/uploads/2014/11/Cat-in-the-Hat-funny-cute-animal-pictures.jpg",
    "http://images4.fanpop.com/image/photos/17800000/Cute-Panda-Cubs-Together-pandas-17838800-450-324.jpg",
    "http://www.funchap.com/wp-content/uploads/2014/05/help-dog-picture.jpg"
  ]
  end

  on :message, /cranky/i do |m|
    reply_random m, [
    "http://i272.photobucket.com/albums/jj172/lnglgs/cranky.jpg",
    "http://wac.450f.edgecastcdn.net/80450F/943thepoint.com/files/2012/06/cranky-baby-630x420.jpg",
    "http://res.mindbodygreen.com/img/ftr/MyCrankypants.jpg"
    ]
  end  

  on :message, /^!artist (.+)/ do |m, artists|
    m.reply spotify_artists(artists)
  end

  on :message, /^hello holla_bot_girl/ do |m, nick|
    m.reply "Hello #{m.user.nick}"
  end

  on :message, /^bye holla_bot_girl/ do |m, nick|
    m.reply "Goodbye #{m.user.nick}"
  end

  on :message, /^!me (.+), (.+), (.+)/ do |m, nick, twitter, github|
    DB.instance.new_peep(nick, twitter, github)
    m.reply "You're alive!"
  end

  on :message, /^!stalk (.+)/ do |m, nick|
    peep = DB.instance.lookup_peep(nick)
    if peep
      m.reply "#{peep.get(:nick)} is #{peep.get(:twitter)} on Twitter and #{peep.get(:github)} on Github."
    else
      m.reply "You're stalking in the wrong room"
    end
  end

  on :message, /^my twitter/ do |m| 
    peep = DB.instance.lookup_peep(m.user.nick)
    m.reply "Your twitter handle is #{peep.get(:twitter)}"
  end
end

bot.start

#Other ideas
#help
#points
#dice - will get help with