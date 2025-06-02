class ActiveStorage::Analyzer::ImageAnalyzer::VipsWithDominantColor < ActiveStorage::Analyzer::ImageAnalyzer::Vips

  def metadata
    read_image do |image, file|
      begin
        image = ::Vips::Image.new_from_file(file.path, access: :sequential)
        @dominant_color = Colorscore::HistogramVips.new(file.path).scores&.first&.last&.html
      rescue StandardError => e
        Rails.error.report(e)
        @dominant_color = nil
      end

      if rotated_image?(image)
        { width: image.height, height: image.width, dominant_color: @dominant_color }
      else
        { width: image.width, height: image.height, dominant_color: @dominant_color }
      end
    end
  end

  private

  def read_image
    begin
      require "ruby-vips"
    rescue LoadError
      logger.info "Skipping image analysis because the ruby-vips gem isn't installed"
      return {}
    end

    download_blob_to_tempfile do |file|
      image = instrument("vips") do
        ::Vips::Image.new_from_file(file.path, access: :sequential)
      end

      if valid_image?(image)
        yield image, file
      else
        logger.info "Skipping image analysis because Vips doesn't support the file"
        {}
      end
    rescue ::Vips::Error => error
      logger.error "Skipping image analysis due to an Vips error: #{error.message}"
      {}
    end
  end
end
