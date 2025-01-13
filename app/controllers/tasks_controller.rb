class TasksController < ApplicationController
  before_action :set_list, only: [:new, :create, :edit, :update]
  before_action :set_task, only: [:edit, :update, :destroy]

  def new
    @task = @list.tasks.new
  end

  def create
    @task = @list.tasks.new(task_params)
    @task.user_id = Current.user.id  # Atribui o user_id da sessão à tarefa
  
    if @task.save
      redirect_to dashboard_path, notice: "Tarefa criada com sucesso!"
    else
      render :new
    end
  end
  

  def edit
    @list = @task.list # Agora você carrega a lista associada à tarefa
  end
  

  def update
    if @task.update(task_params)
      redirect_to dashboard_path, notice: "Tarefa atualizada com sucesso!"
    else
      render :edit
    end
  end

  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to dashboard_path(@task.list), notice: "Tarefa excluída com sucesso."
  end
  

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def set_task
    @task = Task.find(params[:id])
  end

  def task_params
    params.require(:task).permit(:title, :description)
  end
end
