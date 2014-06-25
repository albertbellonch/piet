module Piet
  module CarrierWaveExtension
    def optimize(opts = {})
      ::Piet.optimize(current_path, opts)
    end

    def pngquant
      ::Piet.pngquant(current_path)
    end
  end
end
