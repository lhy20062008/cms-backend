class BaseUploader < CarrierWave::Uploader::Base

  def store_dir
    "uploads/#{model.class.to_s.pluralize.underscore}/#{mounted_as}/#{model.id}"
  end

end
