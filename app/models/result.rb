class Result < ApplicationRecord
  belongs_to :quote
  mount_uploader :voice_data, VoiceDataUploader

  def score
    parsed_result_message = JSON.parse result_message
    parsed_result_message['emotion_detail'][quote.emotion] * 100
  end
end
