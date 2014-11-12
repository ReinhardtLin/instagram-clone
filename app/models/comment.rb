class Comment < ActiveRecord::Base
  belongs_to :photo
  belongs_to :user

  validates_presence_of :content

  def title
    self.photo.title
  end

  def can_delete_by?(user)
    ( self.user == user ) || ( self.photo.try(:user) == user ) || user.admin?
  end
end
