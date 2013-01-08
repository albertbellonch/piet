module Piet
  module CarrierWaveExtension
    def optimize
      manipulate! do |img|
        if img.class.to_s == "Magick::Image"
          img.write(current_path)
          Piet.optimize(current_path)
          img_new = ::Magick::Image.read(current_path).first # reopen the img and return
        elsif img.class.to_s == "MiniMagick::Image"
          img.write(img.path)
          Piet.optimize(img.path)
          img_new = ::MiniMagick::Image.open(img.path).first # reopen the img and return
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
          img.write(img.path)
          Piet.pngquant(img.path)
          img_new = ::MiniMagick::Image.open(img.path).first # reopen the img and return
        else
          Piet.pngquant(img.path)
          img_new = img
        end
        img_new
      end
    end
  end
end
