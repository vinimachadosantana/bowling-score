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
      player_array << split(item) if index.zero? || index == 1

      if same_player_name?(player_array.first, item) && !index.zero?
        player_array[0] << split(item).last
      end

      if same_player_name?(player_array.last, item) && index > 1
        player_array[1] << split(item).last
      end
    end

    player_array
  end

  def split(item)
    item.split(' ')
  end

  def same_player_name?(array, item)
    array.first == split(item).first
  end
end

input = $stdin.read
p TextParser.new(input).call
