class ResultsController < ApplicationController
  require 'rest-client'
  require 'json'

  def show
    @result = Result.find_by(uuid: params[:uuid])
    url = 'https://ai-api.userlocal.jp/voice-emotion/basic-emotions' 
    voice = File.new("#{@result.voice_data.path}")
    response = RestClient::Request.execute(
      method: :post,
      url: url,
      payload: {
       multipart: true,
       voice_data: voice
      }
    )
    @data = JSON.parse(response.body)
  end


  def create 
    result =Result.create(result_params.merge(uuid: SecureRandom.uuid))
    render json: { uuid: result.uuid, url: quote_result_url(result.quote_id, result.uuid) }
  end

  private

  def result_params
    params.permit(:quote_id, :result_message, :voice_data )
  end
end