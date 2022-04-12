class WordsController < ApplicationController
  before_action :reset_session

  def show
    if params[:num] == "0"
      @answer = Word.answer(params[:level])
      @options = Word.choices(@answer, params[:level])
      set_session(@answer.ids, params[:num])
    else
      session[:num] = prams[:num]
    end
  end

  private

  def reset_session
    session.delete(:num)
    session.delete(:answer)
  end

  def set_session(ids,num)
    session[:answer] = ids
    session[:num] = num
  end
end
