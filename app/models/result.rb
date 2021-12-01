class Result < ApplicationRecord
  belongs_to :quote
  before_create -> { self.uuid = SecureRandom.uuid }
  mount_uploader :voice_data, VoiceDataUploader
end
