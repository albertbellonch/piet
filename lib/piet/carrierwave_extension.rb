module Piet
  module CarrierWaveExtension
    def optimize
      manipulate! do |img|
        Piet.optimize(img.class.to_s == "Magick::Image" ? img.base_filename : img.path)
        img
      end
    end

    def pngquant
      manipulate! do |img|
        Piet.pngquant(img.class.to_s == "Magick::Image" ? img.base_filename : img.path)
        img
      end
    end
  end
end
