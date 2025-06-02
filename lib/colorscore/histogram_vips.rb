module Colorscore
  class HistogramVips
    attr_reader :histogram

    def initialize(path)
      @histogram = build_histogram(path)
    end

    def colors
      histogram.keys
    end

    def color_counts
      histogram.values
    end

    def scores
      total = color_counts.sum.to_f
      color_counts.map { |count| count / total }.zip(colors)
    end

    private

    def build_histogram(path)
      image = Vips::Image.new_from_file(path, access: :sequential)
      image = image.thumbnail_image(100)

      image = image.bandjoin(255) if image.bands == 3

      width  = image.width
      height = image.height
      bands  = image.bands

      pixels = image.write_to_memory.unpack("C*")

      hist = Hash.new(0)

      (0...(width * height)).each do |i|
        offset = i * bands
        r, g, b, a = pixels[offset, 4]

        next if a < 128
        next if r > 250 && g > 250 && b > 250

        color = Color::RGB.new(r, g, b)
        hist[color] += 1
      end

      hist
    end
  end
end
