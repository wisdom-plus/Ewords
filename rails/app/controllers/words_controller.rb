class WordsController < ApplicationController
  before_action :reset_session

  def show
    @answer = Word.answer(params[:level])
    @options = Word.choices(@answer, params[:level])
    set_session(@answer.ids, 0)
  end

  private

  def reset_session
    session[:answer].clear
    session.delete(:num)
  end

  def set_session(ids,num)
    session[:answer] = ids
    session[:num] = num
  end
end
