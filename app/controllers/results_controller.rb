class ResultsController < ApplicationController
    def show
        @result = Result.find_by(uuid: params[:uuid])
    end
end