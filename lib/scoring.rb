# frozen_string_literal: true

class Scoring
  def call(pinfall_array)
    score_count(pinfall_array)
  end

  private

  def score_count(pinfall_array)
    score = []

    pinfall_array.each do |pinfalls|
      frame = 1
      score_sum = 0
      player_score = []

      pinfalls.each_with_index do |pinfall, index|
        player_score << pinfall if index.zero?
        next_shot = pinfalls[frame + 1]
        frame_score = 0

        if frame == 10
          frame_score = pinfall.map { |str| normalize_value(str) }.sum
        elsif strike?(pinfall)
          if strike?(next_shot)
            if frame == 9
              sum1 = next_shot.map { |str| normalize_value(str) }.sum

              if strike?(pinfall) && all_strikes?(next_shot)
                sum1 -= strike_value(next_shot)
              else
                sum1 -= next_shot.last.to_i
              end
            else
              sum1 = strike_value(next_shot)
              sum2 = strike_value(pinfalls[frame + 2])
            end

            sum1 = 0 if sum1.nil?
            sum2 = 0 if sum2.nil?
          else
            sum1 = spare?(next_shot) ? 10 : next_shot[0].to_i
            sum2 = sum1 == 10 ? 0 : next_shot[1].to_i
          end

          frame_score = 10 + sum1 + sum2
          frame += 1
        elsif spare?(pinfall)
          frame_score = 10 + next_shot.first.to_i
          frame += 1
        else
          unless index.zero?
            frame_score = spare?(pinfall) ? 10 : pinfall.map(&:to_i).sum
            frame += 1
          end
        end

        score_sum += frame_score
        player_score << score_sum unless index.zero?
      end

      score << player_score
    end

    score
  end

  def all_strikes?(array)
    array.all? { |x| x == 'X' }
  end

  def normalize_value(str)
    strike?(str) ? 10 : str.to_i
  end

  def spare?(value)
    value&.include? '/'
  end

  def strike_value(array)
    array&.include?('X') ? 10 : array.map(&:to_i).sum
  end

  def strike?(value)
    value&.include? 'X'
  end
end
