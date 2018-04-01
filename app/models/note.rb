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

end
