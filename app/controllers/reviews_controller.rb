class ReviewsController < ApplicationController
  def index
    @reviews = Review.order(id: :desc).all
    respond_to do |format|
      format.json {render :json => @reviews.to_json(:include => {:order => {:include => {:good => {:include => :good_type}}}})}
    end
  end

  def show
    @review = Review.find(params[:id])
    respond_to do |format|
      format.json { render :json => @review.to_json(:include => {:order => {:include => {:good => {:include => :good_type}}}}) }
    end
  end
end
