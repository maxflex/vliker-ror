class StoreController < ApplicationController

  #
  # GET all goods
  #
  def all
    @goods = Good.all
    respond_to do |format|
      format.html { render :json => @goods.to_json(:include => :good_type) }
      format.json { render :json => @goods.to_json(:include => :good_type) }
    end
  end
end
