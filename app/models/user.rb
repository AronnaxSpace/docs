# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                    :bigint           not null, primary key
#  aronnax_access_token  :string
#  aronnax_refresh_token :string
#  email                 :string           default(""), not null
#  encrypted_password    :string           default(""), not null
#  provider              :string
#  remember_created_at   :datetime
#  uid                   :string
#  created_at            :datetime         not null
#  updated_at            :datetime         not null
#
# Indexes
#
#  index_users_on_email  (email) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :rememberable,
         :validatable, :omniauthable, omniauth_providers: %i[aronnax]

  # associations
  has_many :projects,
           foreign_key: :owner_id,
           dependent: :destroy

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end

  def update_aronnax_credentials(auth)
    update(
      aronnax_access_token: auth.credentials.token,
      aronnax_refresh_token: auth.credentials.refresh_token
    )
  end

  def nickname
    email.split('@').first
  end
end
