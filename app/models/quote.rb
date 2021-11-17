class Quote < ApplicationRecord
    validates :title, presence: true, uniqueness: true
    validates :quote_image, uniqueness: true, allow_blank: true
    validates :opposite_voice, uniqueness: true, allow_blank: true
    validates :emotion, presence: true
    enum emotion: { angry: 0, sad: 1, happy: 2 }
end
