require 'singleton'

class DB
  include Singleton

  def initialize(file = 'sqlite://bot.db')
    @db = Sequel.connect(file)
  end

  def peeps
    @db[:peeps]
  end

  def new_peep(nick,twitter,github)
    peeps.insert(:nick => nick, :twitter => twitter, :github => github)
  end

  def lookup_twitter(nick)
    peeps.filter(:nick => nick)
  end
end