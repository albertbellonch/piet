module Piet
  module CarrierWaveExtension
    def optimize quality=100
      manipulate! do |img|
        opts = {quality: quality}
        Piet.optimize(img.path, opts)
        img
      end
    end

    def pngquant
      manipulate! do |img|
        Piet.pngquant(current_path)
        img
      end
    end
  end
end
