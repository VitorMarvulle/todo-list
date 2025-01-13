class ListsController < ApplicationController
  before_action :set_list, only: %i[show edit destroy]

  def index
    @lists = Current.user.lists
  end

  def new
    @list = Current.user.lists.new
  end

  def create
    @list = Current.user.lists.new(list_params)
    if @list.save
      redirect_to dashboard_path, notice: "Lista criada com sucesso!"
    else
      render :new
    end
  end

  def destroy
    @list.destroy
    redirect_to dashboard_path, notice: "Lista excluída com sucesso!"
  end

  private

  def set_list
    @list = Current.user.lists.find(params[:id])
  end

  def list_params
    params.require(:list).permit(:title)
  end
end
