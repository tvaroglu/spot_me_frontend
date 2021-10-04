module ApplicationHelper
  # This helper method allows us to display SVG images in the views.
  # See this reference for an explanation of the helper method:
  #   https://blog.cloud66.com/using-svgs-in-a-rails-stack/
  def embedded_svg(filename, options = {})
    assets = Rails.application.assets
    asset = assets.find_asset(filename)

    if asset
      file = asset.source.force_encoding('UTF-8')
      doc = Nokogiri::HTML::DocumentFragment.parse file
      svg = doc.at_css 'svg'
      svg['class'] = options[:class] if options[:class].present?
    else
      doc = "<!-- SVG #{filename} not found -->"
    end

    raw doc
  end
end
