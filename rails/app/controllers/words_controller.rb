class WordsController < ApplicationController
  before_action :reset_session ,if: :first_time?

  def show
    ids =
      if first_time?
        ids = Word.answer_ids(params[:level])
      else
        ids = session[:answer_ids]
      end
    @answer =Word.find_by(id: ids[params[:num].to_i])
    @options = Word.choices(@answer, params[:level])
    set_session(ids, params[:num])
  end

  private

  def first_time?
    params[:num] == "0"
  end

  def reset_session
    session.delete(:num)
    session.delete(:answer_ids)
  end

  def set_session(ids,num)
    session[:answer_ids] = ids
    session[:num] = num
  end
end
