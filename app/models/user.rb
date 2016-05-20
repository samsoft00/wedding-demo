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
	#::::::::::::::::: Params for Mailboxers :::::::::::::::

	private

		def downCaseParams
			self.email = email.downcase
		end

end
