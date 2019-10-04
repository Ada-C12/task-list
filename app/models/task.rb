class Task < ApplicationRecord
    validates :name, presence: true
    validates :description, presence: true
    validates :completion_date, presence: true
end
