module Piet
  module CarrierWaveExtension
    def optimize(opts={})
      manipulate! do |img|
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
