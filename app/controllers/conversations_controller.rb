class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :get_recipient, only: [:show, :create]

	def index
		# @conversations = current_user.mailbox.inbox
		@recipient = User.first
		@conversations = current_user.mailbox.conversations.participant(current_user).participant(@recipient)
	end

	def sent
		@conversations = current_user.mailbox.sentbox
		render action: :index
	end	

	def trash
		@conversations = current_user.mailbox.trash
		render action: :index
	end

	def create
		# params[:related_listing_id].nil?
		# byebug
		current_user.send_message(recipient, params[:mailboxer_message][:body], "Testing Converse")
		# current_user.reply_to_sender(receipt, params[:mailboxer_message][:body])
		# current_user.reply_to_conversation(conversation, params[:mailboxer_message][:body])
	end

	def show
		if @recipient
			@conversations = current_user.mailbox.conversations
			@message = Mailboxer::Message.new
		else
			errors.add[:username] << "Sorry, we could not find a user by that name in your conversations inbox."
			redirect_to conversations_path
		end

	end

	private

		def get_recipient
			@recipient = User.find_by_username(params[:username])
		end

end