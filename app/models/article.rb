class Article < ActiveRecord::Base
  has_many :comments
  has_many :taggings
  has_many :tags, through: :taggings

  def tag_list
    self.tags.collect do |tag|
      tag.name
    end.join(", ")
  end

  def tag_list=(tags_string)
    tag_names = tags_string.split(',').collect do |string|
      string.strip.downcase
    end.uniq

    new_or_found_tags = tag_names.collect do |tag_name|
      Tag.find_or_create_by(name: tag_name)
    end

    self.tags = new_or_found_tags
  end

end
