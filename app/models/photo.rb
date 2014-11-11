class Photo < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  has_many :likes
  has_many :follows

  has_many :users, :through => :comments
  has_many :users, :through => :likes
  has_many :users, :through => :follows

  validates_presence_of :logo_file_name, :title
  has_attached_file :logo, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/:style/missing.png"
  validates_attachment_content_type :logo, :content_type => /\Aimage\/.*\Z/
end
