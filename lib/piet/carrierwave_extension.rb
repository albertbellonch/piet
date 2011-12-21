module Piet
  module CarrierWaveExtension
    def optimize
      manipulate! do |img|
        Piet.optimize(img.path)
        img
      end
    end
  end
end
