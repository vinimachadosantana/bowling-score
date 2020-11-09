# frozen_string_literal: true

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

    parsed_txt.each do |item|
      player_name = split(item).first
      player_score = split(item).last

      player_array << player_name.split unless player_array.flatten.include? player_name

      player_array.each do |array|
        array << player_score if array.include? player_name
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
