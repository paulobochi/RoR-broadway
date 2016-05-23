class PlaysController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_play, only: [:edit, :update, :destroy]

  def index
    @plays = Play.all.order('created_at DESC')
  end

  def show
    @play = Play.find(params[:id])
  end

  def new
    @play = Play.new
  end

  def create
    @play = Play.new(play_params)
    if @play.save
      redirect_to root_path
    else
      redner 'new'
    end
  end

  def edit
  end

  def update
    if @play.update(play_params)
      redirect_to play_path(@play)
    else
      render 'edit'
    end
  end

  def destroy
    @play.destroy
    redirect_to root_path
  end

  private

  def play_params
    params.require(:play).permit(:title, :description, :director)
  end

  def find_play
    @play = current_user.plays.find(params[:id])
  end

end
