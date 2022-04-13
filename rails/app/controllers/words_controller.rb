class WordsController < ApplicationController
  before_action :reset_session, if: :first_question?

  def show
    if first_question?
      ids = Word.answer_ids(params[:level])
    else
      ids = session[:answer_ids]
    end
    @answer = Word.find(ids[params[:num].to_i])
    @options = Word.choices(@answer)
    set_session(ids, params[:num])
  end

  private

    def first_question?
      params[:num] == '0'
    end

    def reset_session
      session.delete(:num)
      session.delete(:answer_ids)
      session.delete(:correct_answers)
    end

    def set_session(ids, num)
      session[:answer_ids] = ids
      session[:num] = num
    end
end
