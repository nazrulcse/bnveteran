module ApplicationHelper
  def belongs_to_user?(resource)
    resource.user == current_user
  end

  def activity_resources_exist?(activity)
    activity && activity.trackable && activity.owner
  end

  def facility_logo(facility, klass = 'image-responsive ')
    html = "<div class='table-class'>"
    if facility.organization_logo.present?
      html += image_tag(facility.organization_logo.url, class: klass)
    else
      html += "<div style='text-align: center;' class=''> #{facility.short_name} </div>"
    end
    raw html + "</div>"
  end

  def menu_bar_items
    MenuBarItem.all
  end

  def page_banners
    PageBanner.all
  end

  def get_rank(type, rank_no)
    if type == 1
      flat_array = User::OFFICER.flatten
    else
      flat_array = User::JCO.flatten
    end
    rank_index = flat_array.index(rank_no)
    flat_array[rank_index - 1]
  end

  def get_user_rank(rank_no)
    flat_array = User::RANK.flatten
    rank_index = flat_array.index(rank_no)
    flat_array[rank_index - 1]
  end

  def format_date(date)
    date.strftime('%d %B, %Y') if date.present?
  end

  def format_date_chat(date)
    date.strftime('%b %d ') if date.present?
  end

  def meta_og_tags(properties = {})
    return unless properties.is_a? Hash

    tags = []

    properties.each do |property, value|
      tags << tag(:meta, property: "og:#{property}", content: value)
    end

    tags.join.html_safe  # Remember in Ruby the last line is returned
  end

end
