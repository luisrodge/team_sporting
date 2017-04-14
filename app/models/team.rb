class Team < ApplicationRecord
	has_many :memberships, dependent: :destroy
	has_many :users, -> { distinct }, through: :memberships

	has_one :captain_membership, -> { where captain: true}, class_name: 'Membership', dependent: :destroy
  has_one :captain, through: :captain_membership, source: :user

  belongs_to :tournament
	belongs_to :color

	validates_presence_of :color

	def is_member?(user)
		users.exists?(user)
	end

	def remaining_space
		tournament.team_size - users.count
	end

end
