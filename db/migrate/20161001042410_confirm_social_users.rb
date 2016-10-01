class ConfirmSocialUsers < ActiveRecord::Migration[5.0]
  def change
    transaction do
      User.where.not(provider: 'email').each do |user|
        user.password = Devise.friendly_token[0,20]
        user.confirmed_at = DateTime.now
        user.save!
      end
    end
  end
end
