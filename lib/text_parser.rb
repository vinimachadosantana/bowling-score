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
    JSON.parse(@txt.to_json).split("\n")
  end
end

input = $stdin.read
p TextParser.new(input).call
