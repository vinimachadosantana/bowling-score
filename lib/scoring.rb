# frozen_string_literal: true

class Scoring
  def call(pinfall_array)
    score_count(pinfall_array)
  end

  private

  def score_count(pinfall_array)
    score = []

    pinfall_array.each do |pinfalls|
      player_score = []
      score_sum = 0
      frame = 1

      pinfalls.each_with_index do |pinfall, index|
        player_score << pinfall if index.zero?
        frame_score = 0

        if frame == 10
          frame_score = pinfall.map { |str| normalize_value(str) }.sum
        elsif strike?(pinfall)
          if strike?(pinfalls[frame + 1])
            if frame == 9
              if strike?(pinfall) && all_strikes?(pinfalls[frame + 1])
                sum1 = pinfalls[frame + 1].map { |str| normalize_value(str) }.sum
                sum1 -= strike_value(pinfalls[frame + 1])
              else
                sum1 = pinfalls[frame + 1].map { |str| normalize_value(str) }.sum
                sum1 -= pinfalls[frame + 1].last.to_i
              end
            else
              sum1 = strike_value(pinfalls[frame + 1])
              sum2 = strike_value(pinfalls[frame + 2])
            end

            sum1 = 0 if sum1.nil?
            sum2 = 0 if sum2.nil?
          else
            sum1 = spare?(pinfalls[frame + 1]) ? 10 : pinfalls[frame + 1][0].to_i
            sum2 = sum1 == 10 ? 0 : pinfalls[frame + 1][1].to_i
          end

          frame_score = 10 + sum1 + sum2
          frame += 1
        elsif spare?(pinfall)
          frame_score = 10 + pinfalls[frame + 1].first.to_i
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
