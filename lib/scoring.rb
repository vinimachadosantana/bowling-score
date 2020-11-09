# frozen_string_literal: true

class Scoring
  def call(pinfall_array)
    p score_count(pinfall_array)
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
          frame_score = pinfall.map { |str| str == 'X' ? 10 : str.to_i }.sum
        elsif pinfall.include? 'X'
          if !pinfalls[frame + 1]&.include?('X')
            sum1 = pinfalls[frame + 1]&.include?('/') ? 10 : pinfalls[frame + 1][0].to_i
            sum2 = sum1 == 10 ? 0 : pinfalls[frame + 1][1].to_i
          else
            if frame == 9
              sum1 = pinfalls[frame + 1].map { |str| str == 'X' ? 10 : str.to_i }.sum
              sum1 -= pinfalls[frame + 1].last.to_i
            else
              sum1 = pinfalls[frame + 1]&.include?('X') ? 10 : pinfalls[frame + 1]&.map { |str| str.to_i }&.sum
              sum2 = pinfalls[frame + 2]&.include?('X') ? 10 : pinfalls[frame + 2]&.map { |str| str.to_i }&.sum
            end

            sum1 = 0 if sum1.nil?
            sum2 = 0 if sum2.nil?
          end

          frame_score = 10 + sum1 + sum2
          frame += 1
        elsif pinfall.include? '/'
          frame_score = 10 + pinfalls[frame + 1].first.to_i
          frame += 1
        else
          unless index.zero?
            frame_score = pinfall.include?('/') ? 10 : pinfall.map { |str| str.to_i }.sum
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
end
