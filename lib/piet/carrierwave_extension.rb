module Piet
  module CarrierWaveExtension
    def optimize
      manipulate! do |img|
        if img.class.to_s == "Magick::Image"
          img.write(current_path)
          Piet.optimize(current_path)
          img_new = ::Magick::Image.read(current_path).first # reopen the img and return
        elsif img.class.to_s == "MiniMagick::Image"
          Piet.optimize(img.path)          
          img_new = img
        else
          Piet.optimize(img.path)
          img_new = img
        end
        img_new
      end
    end

    def pngquant
      manipulate! do |img|
        if img.class.to_s == "Magick::Image"
          img.write(current_path)
          Piet.pngquant(current_path)
          img_new = ::Magick::Image.read(current_path).first # reopen the img and return
        elsif img.class.to_s == "MiniMagick::Image"
          Piet.pngquant(img.path)          
          img_new = img
        else
          Piet.pngquant(img.path)
          img_new = img
        end
        img_new
      end
    end
  end
end
