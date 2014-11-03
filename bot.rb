require 'cinch'

bot = Cinch::Bot.new do
  configure do |c|
    c.server = "irc.freenode.net"
    c.user = "holla_bot_girl"
    c.nick = "holla_bot_girl"
    c.channels = ["#cinch-bots"]
  end

  def reply_random(m,list)
    m.reply list.sample
  end

  on :message, /^!britney/ do |m|
    m.reply "britneywright made me"
  end

  on :message, /^!cute$/ do |m|
    reply_random m, [
    'http://justcuteanimals.com/wp-content/uploads/2014/11/Cat-in-the-Hat-funny-cute-animal-pictures.jpg',
    'http://images4.fanpop.com/image/photos/17800000/Cute-Panda-Cubs-Together-pandas-17838800-450-324.jpg',
    'http://www.funchap.com/wp-content/uploads/2014/05/help-dog-picture.jpg'
  ]
  end

  on :message, /cranky/ do |m|
    reply_random m, [
    'http://i272.photobucket.com/albums/jj172/lnglgs/cranky.jpg',
    'http://wac.450f.edgecastcdn.net/80450F/943thepoint.com/files/2012/06/cranky-baby-630x420.jpg',
    'http://res.mindbodygreen.com/img/ftr/MyCrankypants.jpg'
    ]
  end  
end

bot.start