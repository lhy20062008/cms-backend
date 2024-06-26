module ApplicationHelper
  include AuditLog
  def pagination(objects)
    begin
      {
        current_page: objects.current_page,
        next_page: objects.next_page,
        prev_page: objects.prev_page,
        total_pages: objects.total_pages,
        total_count: objects.total_count
      }
    rescue
      {
        current_page: 1,
        next_page: nil,
        prev_page: nil,
        total_pages: nil,
        total_count: objects.try(:count)
      }
    end
  end

  def format_time datetime
    datetime&.strftime('%Y-%m-%d %H:%M:%S')
  end

  def format_date datetime
    datetime&.strftime('%Y-%m-%d')
  end

  def human_attribute(model, attribute)
    I18n.t("activerecord.attributes.#{model}.#{attribute}", default: attribute.titleize)
  end

  def human_action(name)
    I18n.t("actions.#{name}")
  end
end
