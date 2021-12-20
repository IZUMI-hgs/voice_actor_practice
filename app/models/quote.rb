class Quote < ApplicationRecord
    mount_uploader :quote_image, QuoteImageUploader
    mount_uploader :opposite_voice, OppositeVoiceUploader
    validates :title, presence: true, uniqueness: true
    validates :emotion, presence: true
    enum emotion: { angry: 0, sad: 1, happy: 2, disgust: 3 }
    has_many :results
end
