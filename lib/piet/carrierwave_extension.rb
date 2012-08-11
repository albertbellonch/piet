module Piet
  module CarrierWaveExtension
    def optimize
      manipulate! do |img|
        if img.class.to_s == "Magick::Image"
          img.write(current_path)
          Piet.optimize(current_path)
          img = ::RMagick::Image.read(current_path) # reopen the img and return
        elsif img.class.to_s == "MiniMagick::Image"
          img.write(img.path)
          Piet.optimize(img.path)
          img = ::MiniMagick::Image.open(img.path) # reopen the img and return
        else
          Piet.optimize(img.path)        
        end
        img
      end
    end

    def pngquant
      manipulate! do |img|
        if img.class.to_s == "Magick::Image"
          img.write(current_path)
          Piet.pngquant(current_path)
          img = ::RMagick::Image.read(current_path) # reopen the img and return
        elsif img.class.to_s == "MiniMagick::Image"
          img.write(img.path)
          Piet.pngquant(img.path)
          img = ::MiniMagick::Image.open(img.path) # reopen the img and return
        else
          Piet.pngquant(img.path)
        end
        img
      end
    end
  end
end
