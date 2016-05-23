class ReviewsController < ApplicationController

  before_action :authenticate_user!, excepts: [:show]
  before_action :find_play, only: [:new, :create]

  def new
    @review = Review.new
  end

  def create
    @review = current_user.reviews.build(review_params)
    @review.play = @play

    if @review.save
      redirect_to play_path(@play)
    else
      'new'
    end
  end

  private

  def review_params
    params.require(:review).permit(:rating, :comment)
  end

  def find_play
    @play = Play.find(params[:play_id])
  end

end
