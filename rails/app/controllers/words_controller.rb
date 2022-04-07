class WordsController < ApplicationController
  def show
    @num = 0
    @answer = Word.answer(params[:level])
    @options = Word.choices(@answer, params[:level])
  end
end
