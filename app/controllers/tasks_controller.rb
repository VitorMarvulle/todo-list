class TasksController < ApplicationController
  before_action :authenticate_user!
  before_action :set_task, only: %i[show edit update destroy]

  def index
    @tasks = Current.user.tasks
  end

  def new
    @task = Current.user.tasks.new
  end

  def create
    @task = Current.user.tasks.new(task_params)

    if @task.save
      redirect_to tasks_path, notice: "Task was successfully created."
    else
      render :new
    end
  end

  def edit; end

  def update
    if @task.update(task_params)
      redirect_to tasks_path, notice: "Task was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @task.destroy
    redirect_to tasks_path, notice: "Task was successfully deleted."
  end

  private

  def set_task
    @task = Current.user.tasks.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
