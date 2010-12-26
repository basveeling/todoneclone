class User < ActiveRecord::Base
  has_many :todos
  
  validates :name, :presence => true, :uniqueness => true
  validates :email, :presence => true
  
  validates :password, :confirmation => true
  attr_accessor :password_confirmation
  attr_reader :password
  
  validate :password_must_be_present
  
  class << self
    def encrypt_password(password)
      Digest::SHA2.hexdigest(password + 'letsbedonewiththis')
    end
    
    def authenticate(name, password)
      if user = find_by_name(name)
        if user.hashed_password == encrypt_password(password)
          user
        end
      end
    end
  end
  
  def password=(password)
    @password = password
    if password.present?
      puts password
      self.hashed_password = self.class.encrypt_password(password)
    end
  end
  
  private
  
  def password_must_be_present
    errors.add(:password, "can't be missing.") unless hashed_password.present?
  end
  

  
  
end
