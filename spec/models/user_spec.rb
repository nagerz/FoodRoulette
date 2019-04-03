require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:google_id) }
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
  end

  describe 'class methods' do
    it '.update_or_create' do
      oauth_data = {
        provider: "google",
        uid: "108693550823420995807",
        info: {
          email: "marcootj@gmail.com",
          first_name: "Julia",
          last_name: "Marco",
          image: "https://lh6.googleusercontent.com/-v5E7X9BssFY/AAAAAAAAAAI/AAAAAAAAAAA/ACHi3rc9ovNgz_Eslf59KrWqo3Oi7jQLMQ/mo/photo.jpg"
        },
        credentials: {
          token: ENV['TOKEN'],
          refresh_token: ENV['REFRESH_TOKEN'],
          expires_at: 1554258409
        }
      }

      User.update_or_create(oauth_data)
      user = User.last
      expect(user.google_id).to eq("108693550823420995807")
      expect(user.email).to eq("marcootj@gmail.com")
      expect(user.first_name).to eq("Julia")
      expect(user.last_name).to eq("Marco")
      expect(user.token).to eq(ENV['TOKEN'])
    end
  end
end
