module CmsHelper
  include Cms::UiHelper
  include Cms::FilterHelper
  def create_action model
    {
      name: I18n.t('actions.create'),
      action: 'navigation',
      path: "#{model}/create"
    }
  end

  def default_order
    "deleted_at desc, id desc"
  end

  def updating?
    @action_name == 'update'
  end

  def custom_clickable object
    return unless object.present?
    return product_clickable(object) if object.is_a?(Product)
    clickables = []
    clickables << {model_name: object.class.name.tableize, id: object.id, name: object.display_name} if object
    {clickables: clickables}
  end

  def custom_clickables objects
    clickables = []
    objects&.each do |object|
      clickables << {model_name: object.class.name.tableize, id: object.id, name: object.display_name}
    end
    {clickables: clickables}
  end

  def number_to_currency(number, options = { unit: 'S$' })
    if options[:unit].nil?
      options[:unit] = ''
    end
    super(number, options)&.to_s&.strip
  end

  def enum_values model, enums
    model.classify.constantize.send(enums).keys.collect{|enum| { label: I18n.t("enums.#{model}.#{enums}.#{enum}", default: enum.titleize), value: enum }}
  end
end