class ExamsController < ApplicationController
  load_resource :only => [:show, :update, :destroy, :edit, :new]
  authorize_resource

  def index
    @exams = Exam.all
  end

  def create
    @exam = Exam.create(exam_params)
    if @exam.errors.present?
      flash.now[:fail] = I18n.t :fail, :scope => [:exam, :create]
      render "new"
    else
      flash.now[:success] = I18n.t :success, :scope => [:exam, :create]
      render "show"
    end
  end

  def update
    if @exam.update(exam_params)
      flash.now[:success] = I18n.t :success, :scope => [:exam, :update]
      render "show"
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:exam, :update]
      render "edit"
    end
  end

  def destroy
    if @exam.destroy
      flash.now[:success] = I18n.t :success, :scope => [:exam, :destroy]
      redirect_to exams_path
    else
      flash.now[:fail] = I18n.t :fail, :scope => [:exam, :destroy]
    end
  end

  private

  def exam_params
    params.require(:exam).permit(:subject, :semister, :exam_name, :course_id, :duration, :no_of_questions, :pass_criteria_1, :pass_text_1, :pass_criteria_2, :pass_text_2, :pass_criteria_3, :pass_text_3, :pass_criteria_4, :pass_text_4, :negative_mark, :fill_in_blanks, :multiple_choice)
  end

end
