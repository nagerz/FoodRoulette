class User < ApplicationRecord
  validates :email, uniqueness: true, presence: true
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_presence_of :google_id

  def self.update_or_create(oauth_data)
    user = User.find_by(google_id: oauth_data[:uid]) || User.new
    user.attributes = {google_id: oauth_data[:uid],
                      first_name: oauth_data[:info][:first_name],
                      last_name: oauth_data[:info][:last_name],
                      email: oauth_data[:info][:email],
                      token: oauth_data[:credentials][:token]
                      }
    if user.save!
      return user
    else
      nil
    end
  end
end
