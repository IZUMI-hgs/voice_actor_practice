class Result < ApplicationRecord
  belongs_to :quote
  mount_uploader :voice_data, VoiceDataUploader
end
