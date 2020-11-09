# frozen_string_literal: true

class Bowling
  def initialize(
    parse_txt: TextParser.new,
    pinfall: Pinfall.new,
    scoring: Scoring.new
  )
    @parse_txt = parse_txt
    @scoring = scoring
    @pinfall = pinfall
  end

  def call
    parsed_txt = @parse_txt.call
    pinfall = @pinfall.call(parsed_txt)
    scoring = @scoring.call(pinfall)
  end
end
