class WordsController < ApplicationController
  def show
    @answer = Word.answer(show_params)
    @options = Word.choices(answer, show_params)
  end

  private

    def show_params
      params.require(:word).permit(:level)
    end
end
