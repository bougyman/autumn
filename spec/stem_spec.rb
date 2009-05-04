require 'logger'
require 'set'

require 'autumn'
require 'autumn/genesis'

gen = Autumn::Genesis.new
gen.load_libraries
gen.load_daemon_info

describe Autumn::Stem do
  before :all do
    #TODO how do we stub these methods?
    Autumn::Leaf.class_eval do
      def irc_privmsg_event(*args); true; end
      def irc_join_event(*args); true; end
      def irc_part_event(*args); true; end
      def irc_mode_event(*args); true; end
      def irc_topic_event(*args); true; end
      def irc_invite_event(*args); true; end
      def irc_kick_event(*args); true; end
      def irc_notice_event(*args); true; end
    end
  end
  
  
   
  describe "when an irc message is received" do
    
    before :all do
      class Autumn::Stem;public :receive;end
      @logger = Autumn::LogFacade.new Logger.new(STDOUT), 'Stem', 'Stem Spec'
      @stem = Autumn::Stem.new('irc.mockserver.com', 'MockStem', { :logger => @logger, :channels => [ '#listening', '#notlistening' ]})
      Autumn::Foliater.instance.stems['Mock'] = @stem
      @sender_hash = { :nick => 'nick', :host => 'ca.us.host.com', :user => 'user' }
    end

    describe "And it is a quit event" do
      describe "With a valid quit message" do

        before :all do
          @resp = @stem.receive(":Towzzer!bowzer@bowzzer.com QUIT :Remote host closed the connection")
        end

        it "should be a Hash" do
          @resp.should be_an_instance_of(Hash)
        end

        it "should populate :irc_quit_event" do
          @resp.should have_key(:irc_quit_event)
          @resp[:irc_quit_event].should be_an_instance_of(Array)
        end

        it "should have 3 arguments to :irc_quit_event" do
          @resp[:irc_quit_event].should have(3).items
        end
        
        it "should have an Autumn::Stem as :irc_quit_event's first item" do
          @resp[:irc_quit_event].first.should be_an_instance_of(Autumn::Stem)
        end
        
        it "should have a sender hash as :irc_quit_event's second item" do
          @resp[:irc_quit_event][1].should be_an_instance_of(Hash)
          @resp[:irc_quit_event][1].keys.should include(:nick, :user, :host)
        end

        it "should have a message hash as :irc_quit_event's second item" do
          @resp[:irc_quit_event][2].should be_an_instance_of(Hash)
          @resp[:irc_quit_event][2].keys.should include(:message)
        end
      end

      describe "With no quit message" do

        before :all do
          @resp = @stem.receive(":_anm!n=_anm@69.85.248.2 QUIT :Read error: 110 (Connection timed out)")
        end

        it "should be a Hash" do
          @resp.should be_an_instance_of(Hash)
        end

        it "should populate :irc_quit_event" do
          @resp.should have_key(:irc_quit_event)
          @resp[:irc_quit_event].should be_an_instance_of(Array)
        end

        it "should have 3 arguments to :irc_quit_event" do
          @resp[:irc_quit_event].should have(3).items
        end
        
        it "should have an Autumn::Stem as :irc_quit_event's first item" do
          @resp[:irc_quit_event].first.should be_an_instance_of(Autumn::Stem)
        end
        
        it "should have a sender hash as :irc_quit_event's second item" do
          @resp[:irc_quit_event][1].should be_an_instance_of(Hash)
          @resp[:irc_quit_event][1].keys.should include(:nick, :user, :host)
        end

        it "should have a message hash as :irc_quit_event's second item" do
          @resp[:irc_quit_event][2].should be_an_instance_of(Hash)
          @resp[:irc_quit_event][2].keys.should include(:message)
        end
      end

    end
  end
end
