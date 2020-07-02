class User < ApplicationRecord
  validates :username, :session_token, :password, presence: true
  validates :username, :session_token, uniqueness: true
  validates :password_digest, presence: { message: "Password is required" }
  validates :password, length: { minimum: 6, allow_nil: true }

  attr_reader :password

  before_validation :ensure_session_token

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    if BCrypt::Password.create(user.password_digest).is_password?(password)
      return user
    else
      redirect_to new_users_url
      flash[:notice] = "Credentials are invalid, please try again."
    end
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.generate_session_token
    self.save!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.generate_session_token
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

end
