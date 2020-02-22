class User < ApplicationRecord
    acts_as_paranoid
    has_secure_password
    
    validates :email, presence: true, uniqueness: true
    validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
    validates :name, presence: true
    validates :password, length: { minimum: 6 },
                         presence: true, 
                         if: :password

    has_many :places
    has_many :ratings

    def self.return_data(user_id)
        User.where(id: user_id)
            .select(:name, :email)
    end
end
  