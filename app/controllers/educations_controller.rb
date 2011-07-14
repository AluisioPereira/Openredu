class EducationsController < ApplicationController
  respond_to :js

  load_resource :user
  load_and_authorize_resource :education, :through => :user

  def create
    if params.has_key? :high_school
      educationable = HighSchool.new(params[:high_school])
    elsif params.has_key? :higher_education
      educationable = HigherEducation.new(params[:higher_education])
    end
    @education = Education.new
    @education.user = current_user
    @education.educationable = educationable
    @education.save

    respond_with(@user, @education)
  end

  def update
    if params.has_key? :high_school
      @education.educationable.attributes = params[:high_school]
    elsif params.has_key? :higher_education
      @education.educationable.attributes = params[:higher_education]
    end
    @education.educationable.save

    respond_with(@user, @education)
  end

  def destroy
    @education.destroy

    respond_with(@user, @education)
  end

end
