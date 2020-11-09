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

    bowling_printer(pinfall, scoring)
  end

  private

  def bowling_printer(pinfall, scoring)
    frame_printer && results_printer(pinfall, scoring)
  end

  def frame_printer
    str = 'Frame  '
    range = (1..10).map { |frame| "#{frame}         " }.join

    p "#{str}     #{range}".rstrip
  end

  def results_printer(pinfall, scoring)
    pinfall.each do |pinfalls|
      player_printer(pinfalls.shift) && pinfall_printer(pinfalls)
    end
  end

  def player_printer(player)
    p player
  end

  def pinfall_printer(pinfalls)
    str = 'Pinfalls'
    pinfall = pinfalls.flatten.map { |frame| "#{frame}    " }.join

    p "#{str}    #{pinfall}".rstrip
  end
end
