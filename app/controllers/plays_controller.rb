class PlaysController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_play, only: [:edit, :update, :destroy]

  def index
    if (params[:category].blank?)
      @plays = Play.all.order('created_at DESC')
    else
      category = Category.find_by(name: params[:category])
      @plays = []
      if !category.blank?
        @plays = Play.where(category_id: category.id).order('created_at DESC')
      end
    end
  end

  def show
    @play = Play.find(params[:id])
    if @play.review.blank?
      @average_review = 0
    else
      @average_review = @play.reviews.average(:rating).round(2)
    end
  end

  def new
    @play = current_user.plays.build
    @categories = Category.all.map{ |c| [c.name, c.id ] }
  end

  def create
    @play = current_user.plays.build(play_params)
    if @play.save
      redirect_to root_path
    else
      redner 'new'
    end
  end

  def edit
    @categories = Category.all.map{ |c| [c.name, c.id ] }
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
    params.require(:play).permit(:title, :description, :director, :category_id, :play_img, :trailer_url)
  end

  def find_play
    @play = current_user.plays.find(params[:id])
  end

end
