# frozen_string_literal: true

class ProjectsController < ApplicationController
  before_action :authorize_access

  def index
    @projects = Project.all_for(current_user)
  end

  def show; end

  def new
    @project = Project.new
  end

  def edit; end

  def create
    @project = Project.new(project_params)
    @project.owner = current_user

    if @project.save
      redirect_to project_url(@project), notice: 'Project was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @project.update(project_params)
      redirect_to project_url(@project), notice: 'Project was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @project.destroy

    redirect_to projects_url, notice: 'Project was successfully destroyed.'
  end

  private

  def authorize_access
    return authorize project if params[:id]

    authorize Project
  end

  def project
    @project ||= Project.find(params[:id])
  end
  helper_method :project

  def project_params
    params.require(:project).permit(:name, :description, :is_public)
  end
end
