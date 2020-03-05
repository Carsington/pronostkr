module MatchesHelper
  def pill_class_names(pill, page_param)
    class_names = ["nav-link"]

    if pill == :upcoming && (first_render? || page_param.present?)
      class_names << 'active'
    elsif pill == :live && page_param.present?
      class_names << 'active'
    elsif pill == :finished && page_param.present?
      class_names << 'active'
    end

    class_names.join(" ")
  end

  def tab_class_names(tab, page_param)
    class_names= %w(tab-pane fade)

    if tab == :upcoming && (first_render? || page_param.present?)
      class_names << 'show' << 'active'
    elsif tab == :live && page_param.present?
      class_names << 'show' << 'active'
    elsif tab == :finished && page_param.present?
      class_names << 'show' << 'active'
    end

    class_names.join(" ")
  end

  def first_render?
    params[:upcoming_page].nil? && params[:live_page].nil? && params[:finished_page].nil?
  end
end
