class QuotesController < ApplicationController
  before_action :set_quote, only: [:show,:update,:edit,:delete ]
  def index
    @quotes = Quote.all
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote =Quote.create(quote_params)
    if @quote.save
      redirect_to quotes_path
    else
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @quote.update(quote_params)
      redirect_to quotes_path
    else
      render :edit
    end
  end

  private
  
  def quote_params
    params.require(:quote).permit(:title, :quote_image, :opposite_voice, :emotion )
  end

  def set_quote
    @quote = Quote.find(params[:id])
  end
end
