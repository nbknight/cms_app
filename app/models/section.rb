class Section < ApplicationRecord

	belongs_to :page, optional: true
	has_many :section_edits
	has_many :admin_users, :through => :section_edits

	scope :visible, lambda { where(:visible => true) }
	scope :invisible, lambda { where(:visible => false) }
	scope :sorted, lambda { order(:position) }
	scope :newest_first, lambda { order("created_at DESC") }

	CONTENT_TYPES = ['text', 'HTML']

	validates_presence_of :name
	validates_length_of :name, :maximum => 255
	validates_inclusion_of :content_type, :in => CONTENT_TYPES, :mesage => "must be one of: #{CONTENT_TYPES.join(', ')}"
	validates_presence_of :content

end
