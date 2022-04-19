class StudyController < ApplicationController
  before_action :reset_session, if: :first_question?, only: :show
  before_action :redirect_result, only: :show

  def index; end

  def show
    ids = answer_ids(params)
    @answer = Word.find(ids[params[:num].to_i])
    @options = Word.choices(@answer)
    set_session(ids, params[:num])
  end

  def result
    @answer_record = Word.where(id: session[:answer_ids]).in_order_of(:id, session[:answer_ids])
    @result = session[:correct_answers]
    @answer_count = @result.count { |answer| answer == 'true' }
  end

  private

    def first_question?
      params[:num] == '0'
    end

    def finish?
      params[:num] == '10'
    end

    def reset_session
      session.delete(:num)
      session.delete(:answer_ids)
      session[:correct_answers] = []
    end

    def set_session(ids, num)
      session[:answer_ids] = ids
      session[:num] = num
    end

    def redirect_result
      return unless finish?

      session[:correct_answers].push(params[:answer])
      redirect_to result_study_index_path, status: :see_other
    end

    def answer_ids(params)
      if first_question?
        ids = Word.answer_ids(params[:level])
      else
        ids = session[:answer_ids]
        session[:correct_answers].push(params[:answer])
      end
      ids
    end
end
