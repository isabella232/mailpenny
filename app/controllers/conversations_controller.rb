class ConversationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_conversation, only: [:show, :edit, :update, :destroy]
  layout 'dashboard'

  # # GET /conversations
  # # GET /conversations.json
  # def index
  #   @conversations = Conversation.all
  # end

  # GET /conversations/1
  # GET /conversations/1.json
  def show
    # make sure the user is authorized to view this conversation
    authorize @conversation

    # update the last accessed times
    @conversation.initiator == current_user ? @conversation.opened_by_initiator : @conversation.opened_by_recipient

    # Build a new message for this conversation
    @message = Message.new
    @message.conversation = @conversation
  end

  # # GET /conversations/new
  # def new
  #   @conversation = Conversation.new
  # end

  # # GET /conversations/1/edit
  # def edit
  # end

  # POST /conversations
  # POST /conversations.json
  def create
    @conversation = Conversation.new(conversation_params)
    @conversation.initiator = current_user
    @conversation.recipient = recipient_from_params
    @conversation.messages << Message.new(message_params)

    authorize @conversation
    if @conversation.save
      redirect_to :back, notice: 'Conversation was successfully created.'
    else
      redirect_to :back, notice: 'Conversation was not sent!'
    end
  end

  # # PATCH/PUT /conversations/1
  # # PATCH/PUT /conversations/1.json
  # def update
  #   respond_to do |format|
  #     if @conversation.update(conversation_params)
  #       format.html { redirect_to @conversation, notice: 'Conversation was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @conversation }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @conversation.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /conversations/1
  # # DELETE /conversations/1.json
  # def destroy
  #   @conversation.destroy
  #   respond_to do |format|
  #     format.html { redirect_to conversations_url, notice: 'Conversation was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_conversation
      @conversation = Conversation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def conversation_params
      params.require(:conversation).permit(:subject)
    end

    def message_params
      params.require(:message).permit(:body)
    end

    def recipient_from_params
      id = params.require(:profile_user).permit(:id)
      User.find_by(id)
    end
end
