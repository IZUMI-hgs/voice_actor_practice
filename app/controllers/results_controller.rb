class ResultsController < ApplicationController
  def show
    @result = Result.find_by(uuid: params[:uuid])
  end

  def create 
    if @result =Result.create(result_params)
      redirect_to quote_result_path(@result.quote_id, @result.uuid)
    else
      render :new
    end    
  end

  private

  def result_params
    params.permit(:quote_id, :result_message, :voice_data, :uuid )
  end
end