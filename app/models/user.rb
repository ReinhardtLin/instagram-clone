class User < ActiveRecord::Base

  has_many :photos
  has_many :comments
  has_many :likes
  has_many :follows

  def self.from_omniauth(auth_hash)
    user = where( :fb_uid => auth_hash[:uid] ).first_or_initialize
    user.name = auth_hash[:info][:name]
    user.email = auth_hash[:info][:email]
    user.fb_token = auth_hash[:credentials][:token]
    user.fb_expires_at = Time.at(auth_hash[:credentials][:expires_at])
    user.save!
    user
  end

  def display_name
    self.name
  end

  def set_admin!
    self.role = "admin"
    self.save!
  end

  def admin?
    self.role == "admin"
  end
end
