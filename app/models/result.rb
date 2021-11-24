class Result < ApplicationRecord
  belongs_to :quote
  before_create -> { self.uuid = SecureRandom.uuid }
end
