class Form < ActiveRecord::Base
	validates :name, :body, :user_id, presence: true

	belongs_to :user
end
