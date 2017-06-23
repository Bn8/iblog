class Article < ApplicationRecord
	has_many :comments
	has_many :taggings
	has_many :tags, through: :taggings

	# paperclip
	has_attached_file :image
	validates_attachment_content_type :image, :content_type => ["image/jpg", "image/jpeg", "image/png"]


	def tag_list
		tags.join(", ")
	end

	def tag_list=(tags_string)
		tag_names = tags_string.split(",").map{|s| s.strip.downcase}.uniq
		self.tags = tag_names.map{|tag_name| Tag.find_or_create_by(name: tag_name)}
	end
end
