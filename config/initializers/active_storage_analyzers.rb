Rails.application.config.to_prepare do
  Rails.application.config.active_storage.analyzers.prepend(
    ActiveStorage::Analyzer::ImageAnalyzer::VipsWithDominantColor
  )
end
