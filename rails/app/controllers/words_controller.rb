class WordsController < ApplicationController

  def show
    if params[:num] == "0"
      reset_session
      ids = Word.answer_ids(params[:level])
      set_session(ids, params[:num])
    else
      ids = session[:answer_ids]
      session[:num] = params[:num]
    end
    @answer =Word.find_by(id: ids[params[:num].to_i])
    @options = Word.choices(@answer, params[:level])
  end

  private

  def reset_session
    session.delete(:num)
    session.delete(:answer_ids)
  end

  def set_session(ids,num)
    session[:answer_ids] = ids
    session[:num] = num
  end
end
