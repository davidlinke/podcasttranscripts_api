class User < ApplicationRecord
    # has_secure_password
    validates :email, presence: true, uniqueness: true
    validates :password, :length => { :minimum => 6 }
    before_save :downcase_email
    after_initialize :set_admin, unless: :persisted?

    p self

    def downcase_email
        self.email = email.downcase
    end

    def set_admin
        self.admin = false if self.admin.nil?
    end
end
