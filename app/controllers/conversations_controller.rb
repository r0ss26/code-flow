class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    # This query accesses the user model and returns all the rows and columns in the user table.
    @users = User.all.paginate(page: params[:page], per_page: 15)

    # Returns all of the conversations which the current user is a member of.
    # The scope for the current users conversations is defined in app/models/conversation.rb

    # This query accesses the Conversation model and returns all the rows and columns in the
    # conversations table. 
    @conversations = Conversation.all
  end

  def create
    if !params[:sender_id]
      redirect_to new_user_session_path, message: { alert: "You must be signed in to send a message"}
    end
    
    # This query uses the custom scope defined in conversation.rb in order
    # check if a conversation between two users already exists, that is if
    # there already exists a conversation with the two users ids as sender
    # or recipient.
    if Conversation.between(params[:sender_id],params[:recipient_id]).present?
      @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
    else
      @conversation = Conversation.create!(conversation_params)
    end
    redirect_to conversation_messages_path(@conversation)
  end
  
  private
  
  def conversation_params
     params.permit(:sender_id, :recipient_id)
  end

end