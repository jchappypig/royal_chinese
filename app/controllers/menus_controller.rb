class MenusController < ApplicationController
  skip_before_filter :authenticate_user!, only: [:show]

  def index
    @menus = Menu.paginate(page: params[:page])
  end

  def show
    @menu = Menu.find(params[:id])
  end

  def new
    @menu = Menu.new
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def create
    @menu = Menu.new(params[:menu])

    if @menu.save
      redirect_to @menu, notice: 'Menu was successfully created.'
    else
      render :new
    end
  end

  def update
    @menu = Menu.find(params[:id])

    if @menu.update_attributes(params[:menu])
      redirect_to @menu, notice: 'Menu was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @menu = Menu.find(params[:id])
    @menu.destroy

    redirect_to menus_url
  end
end
