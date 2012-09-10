class Ticket < ActiveRecord::Base
  belongs_to :project
  belongs_to :user
  has_and_belongs_to_many :tags
  
  validates :title, :presence => true
  validates :description, :presence => true,
                          :length => { :minimum => 10 }
                          
  has_attached_file :asset
  attr_accessible :description, :title, :user, :asset
  
  def tag!(tags)
    tags = tags.split(" ").map do |tag|
      Tag.find_or_create_by_name(tag)
    end
    self.tags << tags
  end
end
