class QuotesController < ApplicationController
  before_action :set_quote, only: [:show, :update, :edit, :delete]
  before_action :login_scan, only: [:new, :create, :edit, :update]
  before_action :admin_scan, only: [:create, :update]
  def index
    @angry_quotes = Quote.angry
    @sad_quotes = Quote.sad
    @happy_quotes = Quote.happy
    @disgust_quotes = Quote.disgust
    @surprise_quotes = Quote.surprise
    @neutral_quotes = Quote.neutral
  end

  def new
    @quote = Quote.new
  end

  def create
    @quote = Quote.create(quote_params)
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
    params.require(:quote).permit(:title, :quote_image, :opposite_voice, :emotion)
  end

  def set_quote
    @quote = Quote.find(params[:id])
  end

  def login_scan
    unless user_signed_in?
      redirect_to root_path
    end
  end

  def admin_scan
    unless current_user.admin?
      redirect_to root_path
    end
  end
end
