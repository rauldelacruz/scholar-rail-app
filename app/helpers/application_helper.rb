module ApplicationHelper

  def boolean_label(value)
    case value
      when true
        content_tag(:span, value, class: "badge bg-success")
      when false
        content_tag(:span, value, class: "badge bg-danger")
    end
  end

  def status_label(status)
    case status
    when "planned"
      content_tag(:span, status.titleize, class: "badge bg-warning")
    when "confirmed"
      content_tag(:span, status.titleize, class: "badge bg-success")
    when "cancelled"
      content_tag(:span, status.titleize, class: "badge bg-danger")
    when "attended"
      content_tag(:span, status.titleize, class: "badge bg-success")
    when "not_attended"
      content_tag(:span, status.titleize, class: "badge bg-danger")
    end
  end

end
