require 'piet/carrierwave_extension'

module Piet
  class << self
    VALID_EXTS = %w{ png gif jpg jpeg }

    def optimize(path, opts= {} )
      output = optimize_for(path, opts)
      puts output if opts[:verbose]
      true
    end

    def pngquant(path)
      PngQuantizator::Image.new(path).quantize!
    end

    private

    def optimize_for(path, opts)
      case extension(path)
        when "png", "gif" then optimize_png(path, opts)
        when "jpg", "jpeg" then optimize_jpg(path, opts)
      end
    end

    def extension(path)
      path.split(".").last.downcase
    end

    def optimize_png(path, opts)
      vo = opts[:verbose] ? "-v" : "-quiet"
      `optipng -o7 #{vo} #{path}`
    end

    def optimize_jpg(path, opts)
      vo = opts[:verbose] ? "-v" : "-q"
      `jpegoptim -f --strip-all #{vo} #{path}`
    end
  end
end
