class QuestionsController < ApplicationController

  def new
    @user = current_user
    @question = @user.questions.build
    @dm = User.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def create
    @question = Question.create(question_params)
    @user = current_user
    @dm = @question.paid_inbox.user

    @user.process_payment_info(params[:stripeToken])

    respond_to do |format|
      format.js
      format.html{
        flash[:success] = 'Question Sent'
        redirect_to schedule_time_path
      }
    end
  end


  private

  def question_params
    params.require(:question).permit(:user_id, :paid_inbox_id, :price_cents, :platform_fee_cents, :question)
  end

end
