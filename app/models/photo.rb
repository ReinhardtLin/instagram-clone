class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :likes
  has_many :follows
  has_many :taggings
  has_many :tags, :through => :taggings

  #has_many :commented_users, :through => :comments, :source => :user
  #has_many :liked_users, :through => :likes, :source => :user
  #has_many :followed_users, :through => :follows, :source => :user

  validates_presence_of :logo_file_name, :title
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/

  def find_by_like(user)
    self.likes.where( :user => user ).first
  end

  def find_by_follow(user)
    self.follows.where( :user => user ).first
  end

  def authors
    arr = [self.user]
    arr = arr +  self.comments.map{ |c| c.user }
    arr.compact.uniq
  end

  def can_delete_by?(user)
    (self.user == user ) || user.admin?
  end

  def all_tags=(names)
    self.tags = names.split(",").map do |name|
      Tag.where(name: name.strip).first_or_create!
    end
  end

  def all_tags
    self.tags.map(&:name).join(", ")
  end

  def self.tagged_with(name)
    Tag.find_by_name!(name).photos
  end
end
