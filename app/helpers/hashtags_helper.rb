module HashtagsHelper


  def hashtags
    SimpleHashtag::Hashtagging.select("simple_hashtag_hashtaggings.hashtag_id, COUNT(simple_hashtag_hashtaggings.hashtaggable_id) as post_count").group('simple_hashtag_hashtaggings.hashtag_id').order("post_count DESC").limit(9)
  end

  def job_hashtag
    SimpleHashtag::Hashtag.find_by_name('#job')
  end

  def linkify_hashtags(hashtaggable_content)
    regex = SimpleHashtag::Hashtag::HASHTAG_REGEX
    hashtagged_content = hashtaggable_content.to_s.gsub(regex) do
      link_to($&, hashtag_path($2), {class: :hashtag})
    end
    hashtagged_content.html_safe
  end

  def render_hashtaggable(hashtaggable)
    klass        = hashtaggable.class.to_s.underscore
    view_dirname = klass.pluralize
    partial      = klass
    render "#{view_dirname}/#{partial}", {klass.to_sym => hashtaggable}
  end


end
