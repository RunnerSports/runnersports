class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:facebook, :google_oauth2]

  def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
    data = access_token.info
    user = User.where(:google_token => access_token.credentials.token, :google_uid => access_token.uid ).first
    return user if user.present?

    existing_user = User.where(:email => data["email"]).first

    if existing_user.present?
      existing_user.update(
        google_uid: access_token.uid,
        google_token: access_token.credentials.token
      )
      existing_user
    else
      new_user = User.create(
        name: data["name"],
        email: data["email"],
        password: Devise.friendly_token[0,20],
        google_token: access_token.credentials.token,
        google_uid: access_token.uid
      )
      new_user
    end
  end

  def self.from_omniauth(auth)
    # Case 1: Find existing user by facebook uid
    user = User.find_by_fb_uid( auth.uid )
    if user
      user.update!(
        fb_token: auth.credentials.token
      )
      return user
    end
    # Case 2: Find existing user by email
    existing_user = User.find_by_email( auth.info.email )
    if existing_user
      existing_user.update!(
        fb_uid:   auth.uid,
        fb_token: auth.credentials.token
      )
      return existing_user
    end
    # Case 3: Create new password
    user = User.create(
      name:     auth.info.name,
      email:    auth.info.email,
      password: Devise.friendly_token[0, 20],
      fb_uid:   auth.uid,
      fb_token: auth.credentials.token
    )
    return user
  end
end
