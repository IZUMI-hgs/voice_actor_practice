class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  rescue_from Exception, with: :render500
  rescue_from ActiveRecord::RecordNotFound, with: :render404

  def render404(exception = nil)
    render template: 'errors/error404', status: 404, layout: 'application'
  end

  def render500(exception = nil)
    logger.error(error.message)
    logger.error(error.backtrace.join("\n"))
    render template: 'errors/error500', status: 500, layout: 'application'
  end
end
