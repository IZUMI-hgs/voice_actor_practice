class ResultsController < ApplicationController
  def show
    @result = Result.find_by(uuid: params[:uuid])
    @display = ResultDisplayService.new(@result).call
  end

  def create
    url = ENV['API_URL']
    voice = File.new(params[:voice_data])
    response = RestClient::Request.execute(
      method: :post,
      url: url,
      payload: {
        multipart: true,
        api_key: ENV['API_KEY'],
        voice_data: voice
      },
      content_type: 'audio/wav'
    )
    result = Result.create(result_params.merge(uuid: SecureRandom.uuid, result_message: response.body))
    render json: { url: quote_result_url(result.quote_id, result.uuid) }
  end

  private

  def result_params
    params.permit(:quote_id, :voice_data)
  end
end
