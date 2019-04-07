require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:google_id) }
    it { should validate_presence_of(:email) }
    it { should validate_uniqueness_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:token) }
    # it { should validate_presence_of(:refresh_token) }
  end

  describe 'relationships' do
    it { should have_many(:surveys) }
    it { should have_many(:visits) }
    it { should have_many(:restaurants).through(:visits) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = create(:user)

      expect(user.role).to eq('user')
      expect(user.user?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = create(:admin)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end

  describe 'Class Methods' do
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
