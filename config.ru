require 'rubygems'
require 'bundler'
Bundler.require

require 'cgi'
require 'active_support/inflector'
require 'yaml'
require_relative "lib/fortune_teller"


COLORS = %w{Red Blue DarkBlue Purple Black Magenta Black Orange Brown Maroon Green Olive}

FORTUNE_TELLER_IMAGES = [
  "https://media.giphy.com/media/CToJzvhONI6A0/giphy.gif",
  "https://scoundreltime.com/wp-content/uploads/2017/07/6938633816_105f6d6cab_b-716x1024.jpg",
  "https://www.sunnyskyz.com/uploads/2017/11/4i5sn-frog-goes-to-fortune-teller-joke.jpg",
  "http://www.calmerkarma.org.uk/FORTUNE-TELLERS-FOR-EVENTS-BLOG_clip_image012.jpg",
  "https://i0.wp.com/ladynicci.com/wp-content/uploads/2015/01/gypsy-2.jpg?resize=600%2C381",
  "https://media.gettyimages.com/photos/fortune-teller-with-glowing-crystal-ball-xxxl-picture-id157524516",
  "https://scoundreltime.com/wp-content/uploads/2017/07/6938633816_105f6d6cab_b-716x1024.jpg"
]


class App < Roda
  development = ENV.fetch("RACK_ENV", "development") == "development"

  opts[:root] = ''
  plugin :render
  plugin :public, root: 'images'
  if development
    plugin :middleware_stack
    # plugin :live_reload, watch: ["images", "views", "lib", "config.ru"]
    
    middleware_stack.before{::BetterErrors::Middleware}
    ::BetterErrors.application_root = __dir__
  end

  route do |r|
    # r.live_reload if development

    r.public

    # GET / request
    r.root do
      r.redirect "/for"
    end

    # /tell branch
    r.get "tell" do
      subjects = YAML.load_file("lib/subjects.yaml")

      @story = Story.new
      @image_url = FORTUNE_TELLER_IMAGES.sample

      @title = "I see #{subjects.count} things in your future!"

      subjects = subjects.shuffle

      sentences = subjects.collect do |opening_word, subject|
        "#{opening_word}, #{@story.sentence(subject)}"
      end

      @lines = sentences.reduce('') do |page, line|
        page += "<p style='color: #{COLORS.sample};'>#{line}</p>"
      end

      view("story")
    end

    r.get "for", String, method: :get do |subject|
      subject = CGI.unescape(subject.titleize)

      @story = Story.new
      @image_url = FORTUNE_TELLER_IMAGES.sample
      @title = "I see a fortune for #{subject}!"
      @lines = "<p style='color: #{COLORS.sample};'>#{@story.sentence(subject)}</p>"

      view("story")
    end

    r.on "for" do
      r.get do
        @title = "Whose fortune should I tell?"
        @image_url = FORTUNE_TELLER_IMAGES.sample

        view("form")
      end

      r.post do
        r.redirect "/for/#{r.params['name']}"
      end
    end
  end
end

run App.freeze.app
