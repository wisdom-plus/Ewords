class WordsController < ApplicationController
  def show
    @answer = Word.answer(params[:level])
    @options = Word.choices(@answer, params[:level])
  end
end
