class StudyController < ApplicationController
  def index; end

  def create
    session[:correct_answers].push(params[:answer])
    redirect_to study_index_path,status: :see_other
  end
end
