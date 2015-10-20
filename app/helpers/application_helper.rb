module ApplicationHelper
  def retina_image_tag(name_at_1x, options={})
    name_at_2x = name_at_1x.gsub(%r{\.\w+$}, '@2x\0')
    image_tag(name_at_1x, options.merge("data-at2x" => asset_path(name_at_2x)))
  end

  # Put this method in your helper file to render inline SVG
  def inline_svg(path)
    file = File.open("vendor/assets/components/SVG-Loaders/svg-loaders/#{path}.svg", "rb")
    raw file.read
  end
end
