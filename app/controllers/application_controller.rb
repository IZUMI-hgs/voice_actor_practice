class ApplicationController < ActionController::Base
  #if Rails.env.production?
    rescue_from Exception, with: :render500
    rescue_from ActiveRecord::RecordNotFound, with: :render404
  #end

  def render404
    render file: "/app/views/errors/error404.html", status: 404
  end

  def render500(error)
    logger.error(error.message)
    logger.error(error.backtrace.join("\n"))
    render file: "/app/views/errors/error500.html", status: 500
  end
end
