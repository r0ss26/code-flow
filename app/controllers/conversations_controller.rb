class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    # Returns all the users to display a list of people available to message.
    @users = User.all.paginate(page: params[:page], per_page: 15)

    # Returns all of the conversations which the current user is a member of.
    # The scope for the current users conversations is defined in app/models/conversation.rb
    @conversations = Conversation.all
  end

  def create
    if !params[:sender_id]
      redirect_to new_user_session_path, message: { alert: "You must be signed in to send a message"}
    end
    
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