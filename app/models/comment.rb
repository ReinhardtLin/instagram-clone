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

  def notify_followers
    self.photo.follows.each do |f|
      if self.user != f.user
        Rails.logger.debug("Send notify to user: #{f.user.id} #{f.user.email}")
        UserMailer.new_comment(f.user, self).deliver
      end
    end
  end

end
