require 'json'

class TextParser
  attr_accessor :txt

  def initialize(txt)
    @txt = txt
  end

  def call
    parser
  end

  private

  def parser
    unite_similars(JSON.parse(@txt.to_json).split("\n"))
  end

  def unite_similars(parsed_txt)
    player_array = []

    parsed_txt.each_with_index do |item, index|
      player_array << item.split(' ') if index == 0
      player_array << item.split(' ') if index == 1

      if player_array[0][0] == item.split(' ').first
        player_array[0] << item.split(' ').last unless index == 0
      end

      if index > 0
        if player_array[1][0] == item.split(' ').first
          player_array[1] << item.split(' ').last unless index == 1
        end
      end
    end

    player_array
  end
end

input = $stdin.read
p TextParser.new(input).call
