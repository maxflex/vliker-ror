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

  def create
    @review = Review.new(review_params)
    respond_to do |format|
      if @review.save
        format.json { render :json => @review, status: :created }
      else
        format.json { render :json => false, status: :unprocessable_entity }
      end
    end
  end

  private
    def review_params
      params.require(:review).permit(:order_id, :text, :status)
    end
end
