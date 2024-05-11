if images.present?
  json.images images do |image|
    next if image.blank?
    json.id image.id
    json.url image.image_url
  end
end
