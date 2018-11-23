require "roda"
require "pry-remote"
require "pry"

require_relative "fortune_teller"
COLORS = %w{AliceBlue AntiqueWhite Aqua Aquamarine Azure Beige Bisque Black BlanchedAlmond Blue BlueViolet Brown BurlyWood CadetBlue Chartreuse Chocolate Coral CornflowerBlue Cornsilk Crimson Cyan DarkBlue DarkCyan DarkGoldenRod DarkGray DarkGrey DarkGreen DarkKhaki DarkMagenta DarkOliveGreen DarkOrange DarkOrchid DarkRed DarkSalmon DarkSeaGreen DarkSlateBlue DarkSlateGray DarkSlateGrey DarkTurquoise DarkViolet DeepPink DeepSkyBlue DimGray DimGrey DodgerBlue FireBrick FloralWhite ForestGreen Fuchsia Gainsboro GhostWhite Gold GoldenRod Gray Grey Green GreenYellow HoneyDew HotPink IndianRed  Indigo  Ivory Khaki Lavender LavenderBlush LawnGreen LemonChiffon LightBlue LightCoral LightCyan LightGoldenRodYellow LightGray LightGrey LightGreen LightPink LightSalmon LightSeaGreen LightSkyBlue LightSlateGray LightSlateGrey LightSteelBlue LightYellow Lime LimeGreen Linen Magenta Maroon MediumAquaMarine MediumBlue MediumOrchid MediumPurple MediumSeaGreen MediumSlateBlue MediumSpringGreen MediumTurquoise MediumVioletRed MidnightBlue MintCream MistyRose Moccasin NavajoWhite Navy OldLace Olive OliveDrab Orange OrangeRed Orchid PaleGoldenRod PaleGreen PaleTurquoise PaleVioletRed PapayaWhip PeachPuff Peru Pink Plum PowderBlue Purple RebeccaPurple Red RosyBrown RoyalBlue SaddleBrown Salmon SandyBrown SeaGreen SeaShell Sienna Silver SkyBlue SlateBlue SlateGray SlateGrey Snow SpringGreen SteelBlue Tan Teal Thistle Tomato Turquoise Violet Wheat White WhiteSmoke Yellow YellowGreen}

class App < Roda
  opts[:root] = ''
  plugin :render
  plugin :public, root: 'images'

  route do |r|
    r.public
    
    # GET / request
    r.root do
      r.redirect "/tell"
    end

    # /tell branch
    r.get "tell" do
      @story = Story.new

      @lines = @story.sentences.reduce('') do |page, line|
        page += "<p style='color: #{COLORS.sample};'>#{line}</p>"
      end

      render("story")
    end
  end
end

run App.freeze.app
