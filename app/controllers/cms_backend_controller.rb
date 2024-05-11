class CmsBackendController < ActionController::API
  include ActionController::ImplicitRender
  include ActionView::Layouts
  include ActionController::Caching
  around_action :set_locale
  rescue_from StandardError, with: :standard_error
  rescue_from SystemError, with: :system_error
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid
  rescue_from Jwt::Error, with: :unauthorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

  layout 'application'

  helper_method :current_admin_user, :human_enum
  private

  def operation_success message = nil, **options
    render json: { request_id: request.uuid, success: true, message: message || I18n.t('operation_success') }.merge(options)
  end

  def operation_failed message = nil, **options
    render json: { request_id: request.uuid, success: false, message: message || I18n.t('operation_failed') }.merge(options)
  end

  def page
    params[:page] || 1
  end

  def per_page
    params[:per_page] || 25
  end

  def default_order
    'id desc'
  end

  def set_locale(&action)
    locale = request.headers['LOCALE'] || I18n.default_locale
    locale = I18n.default_locale unless I18n.available_locales.map(&:to_s).include?(locale.to_s)
    I18n.with_locale(locale, &action)
  end

  def unauthorized
    error = {code: 'unauthorized'}
    render_errors(error, :unauthorized)
  end

  def record_invalid e
    error = {code: 'record_invalid', message: e.message}
    render_errors(error)
  end

  def record_not_found e
    error = {code: 'not_found', message: I18n.t('errors.record_not_found'), model: e.model, primary_key: e.primary_key, id: e.id}
    render_errors(error, :not_found)
  end

  def system_error e
    errors = e.errors
    render_errors(errors)
  end

  def standard_error e
    Rails.logger.info e.full_message
    render_errors({code: :invalid_request, message: e.message})
  end

  def render_errors(errors, status = :unprocessable_entity)
    errors = [errors] unless errors.is_a?(Array)
    sentry_messages = []
    errors.each do |error|
      error[:message] = I18n.t("errors.#{error[:code]}", default: error[:code].titleize) unless error[:message].present?
    end

    render json: {errors: errors, request_id: request.uuid}, status: status
  end
end
