class ApiKey < ActiveRecord::Base
  before_create :generate_token

  validates_presence_of   :token, unless: :new_record?
  validates_uniqueness_of :token

  private
    def generate_token
      begin
        self.token = SecureRandom.hex
      end while self.class.exists?( token: self.token )
    end
end
