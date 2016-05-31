class User < ActiveRecord::Base
	acts_as_messageable

	has_one :profile, dependent: :destroy
	has_one :site, dependent: :destroy
	has_many :listing, dependent: :destroy
	has_many :reviews, dependent: :destroy

	before_save :downCaseParams
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable

  # validates_confirmation_of :password
	validates :username, presence: true, uniqueness: true
						 # uniqueness: { case_sensitive: true},
						 # format: { with: /\A[a-zA-Z]+\z/, :message => "must contain only letters"},
						 # length: {minimum: 5, maximum: 20},
						 # exclusion: { in: %w(www administrator subdomain user admin demo), message: "%{value} is reserved." }


	#::::::::::::::::: Params for Mailboxers :::::::::::::::
	def name
	  current_user.username
	end

	def mailboxer_email(object)
		# current_user.email
		nil
	end	

	def password_required?
	  # Password is required if it is being set, but not for new records
	  if !persisted? 
	    false
	  else
	    !password.nil? || !password_confirmation.nil?
	  end
	end

  # new function to set the password without knowing the current 
  # password used in our confirmation controller. 
  def attempt_set_password(params)
    p = {}
    p[:password] = params[:password]
    p[:password_confirmation] = params[:password_confirmation]
    update_attributes(p)
  end

  # new function to return whether a password has been set
  def has_no_password?
    self.encrypted_password.blank?
  end

  # Devise::Models:unless_confirmed` method doesn't exist in Devise 2.0.0 anymore. 
  # Instead you should use `pending_any_confirmation`.  
  def only_if_unconfirmed
    pending_any_confirmation {yield}
  end

	#::::::::::::::::: Params for Mailboxers :::::::::::::::

	private

		def downCaseParams
			self.email = email.downcase
		end

end
