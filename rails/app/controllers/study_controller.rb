class StudyController < ApplicationController
  before_action :reset_session, if: :first_question?,only: :show
  def index; end

  def show
    if finish?
      session[:correct_answers].push(params[:answer])
      redirect_to result_study_index_path,status: :see_other
      return
    elsif first_question?
      ids = Word.answer_ids(params[:level])
    else
      ids = session[:answer_ids]
      session[:correct_answers].push(params[:answer])
    end
    @answer = Word.find(ids[params[:num].to_i])
    @options = Word.choices(@answer)
    set_session(ids, params[:num])
  end

  def result
    @answer_record = Word.where(id: session[:ansewer_ids])
    @answer = session[:correct_answers]
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
end
