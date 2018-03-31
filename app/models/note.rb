class Note
  include Mongoid::Document
  # this gives us created_at and updated_at funtions for notes
  include Mongoid::Timestamps 

  field :title, type: String
  field :content, type: String

  belongs_to :user
  has_and_belongs_to_many :tags

  
  after_create do 
  	note = Note.find_by(id: self.id)
  	hashtags = note.content.scan(/#\w+/)
  	hashtags.uniq.map do |hashtag|
  		tag = note.tags.find_or_create_by(name: hashtag.downcase.delete('#'))
  		tag.save!
  	end
  end

  after_update do 
  	note = Note.find_by(id: self.id)
  	note.tags.destroy_all
  	hashtags = note.content.scan(/#\w+/)
    hashtags.uniq.map do |hashtag| 
  		tag = note.tags.find_or_create_by(name: hashtag.downcase.delete('#'))
  		tag.save!
  	end
  end



  # def self.tagged_with(name)
  # 	Tag.find_by_name!(name).notes
  # end

  # def self.tag_counts
  # 	Tag.select("tags.*, count(notes_tags.tag_id) as count").
  # 	 joins(:notes_tags).group("notes_tags.tag_id")
  # end

  # def tag_list
  # 	tags.map(&:name).join(", ")
  # end

  # def tag_list=(names)
  # 	self.tags = names.split(",").map do |n|
  # 		Tag.where(name: n.strip).first_or_create!
  # 	end
  # end
end
