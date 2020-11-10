# frozen_string_literal: true

class Pinfall
  def call(parsed_txt)
    pinfall_array = []

    parsed_txt.each do |parsed_array|
      array = []
      frame = 1

      parsed_array.each_with_index do |score, index|
        if index.zero?
          array << score
        elsif frame == 10
          if array.count == 10
            array << (score == '10' ? 'X'.split(//) : score.split(//))
          elsif array.last[1] == '/'
            array.last << if score == '10'
                            'X'
                          else
                            score
                          end
          else
            array.last << if array.last.last.to_i + score.to_i == 10
                            (score == '10' ? 'X' : '/')
                          else
                            (score == '10' ? 'X' : score)
                          end
          end
        elsif array.last.is_a?(Array)
          case score
          when '10'
            if array.last.count == 2
              array << ' '.split(//).append('X')
            else
              array.last << '/'
            end

            frame += 1
          when 'F'
            previous_shot = if array.last.count == 2
                              nil
                            else
                              array.last
                            end

            if previous_shot.nil?
              array << score.split(//)
            else
              previous_shot << score
              frame += 1
            end
          else
            previous_shot = if array.last.count == 2
                              nil
                            else
                              array.last
                            end

            if previous_shot.nil?
              array << score.split(//)
            elsif previous_shot&.first.to_i + score.to_i == 10
              previous_shot << '/'
              frame += 1
            else
              previous_shot << score
              frame += 1
            end
          end
        else
          if score == '10'
            array << ' '.split(//).append('X')
            frame += 1
          else
            array << score.split(//)
          end
        end
      end

      pinfall_array << array
    end

    pinfall_array
  end
end
