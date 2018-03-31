class Tag 
	include Mongoid::Document
 	include Mongoid::Timestamps
 	include Mongoid::Attributes::Dynamic

	field :name, type: String
	has_and_belongs_to_many :notes
end
