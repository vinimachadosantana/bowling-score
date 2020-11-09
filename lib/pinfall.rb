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
            score == '10' ? array << 'X'.split(//) : array << score.split(//)
          elsif array.last[1] == '/'
            if score == "10"
              array.last << 'X'
            else
              array.last << score
            end
          else
            if array.last.last.to_i + score.to_i == 10
              score == '10' ? array.last << 'X' : array.last << '/'
            else
              score == '10' ? array.last << 'X' : array.last << score
            end
          end
        elsif array.last.is_a?(Array)
          if score == '10'
            if array.last.count == 2
              array << ' '.split(//).append('X')
            else
              array.last << '/'
            end

            frame += 1
          elsif score == 'F'
            current_shot = 0

            if array.last.count == 2
              previous_shot = nil
            else
              previous_shot = array.last
            end

            if previous_shot.nil?
              array << score.split(//)
            else
              previous_shot << score
              frame += 1
            end
          else
            current_shot = score&.to_i

            if array.last.count == 2
              previous_shot = nil
            else
              previous_shot = array.last
            end

            if previous_shot.nil?
              array << score.split(//)
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
