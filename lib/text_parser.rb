require 'json'

class TextParser
  attr_accessor :txt

  def initialize(txt: $stdin.read)
    @txt = txt
  end

  def call
    parser
  end

  private

  def parser
    append_player_scores(JSON.parse(@txt.to_json).split("\n"))
  end

  def append_player_scores(parsed_txt)
    player_array = []

    parsed_txt.each_with_index do |item, index|
      unless player_array.flatten.include? split(item).first
        player_array << split(item)
      end

      if same_player_name?(player_array.first, item) && !index.zero?
        player_array.first << split(item).last
      end

      if same_player_name?(player_array.last, item) && index > 1
        player_array.last << split(item).last
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
