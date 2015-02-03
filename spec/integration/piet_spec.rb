require 'spec_helper'

class RMagickUploader < CarrierWave::Uploader::Base
  include CarrierWave::RMagick
  include Piet::CarrierWaveExtension
end

class MiniMagickUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include Piet::CarrierWaveExtension
end

describe Piet do
  describe Piet::CarrierWaveExtension do
    describe ".optimize" do
      let(:path) { File.join('spec', 'assets', 'piet.jpg') }
      let(:image) { File.open(path) }

      let(:fake_png_path) { File.join('spec', 'assets', 'fake-png.png') }
      let(:fake_png_image) { File.open(fake_png_path) }

      let(:real_png_path) { File.join('spec', 'assets', 'real-png.png') }
      let(:real_png_image) { File.open(real_png_path) }

      def upload_file(uploader, image)
        uploader.store!(image)
        uploader.manipulate! do |img|
          img
        end
      end

      it "calls the uploader's `current_path` when MiniMagick is used" do
        uploader = MiniMagickUploader.new

        upload_file(uploader, image)

        expect(Piet).to receive(:optimize).with(uploader.current_path, {})

        uploader.optimize
      end

      it "calls the uploader's `current_path` when RMagick is used" do
        uploader = RMagickUploader.new

        upload_file(uploader, image)

        expect(Piet).to receive(:optimize).with(uploader.current_path, {})

        uploader.optimize
      end

      it "calls `optimize_png` if the file MIME type is that of a PNG" do
        uploader = MiniMagickUploader.new

        upload_file(uploader, real_png_image)

        expect(Piet).to receive(:optimize_png).with(uploader.current_path, {})

        uploader.optimize
      end

      it "calls `optimize_jpg` if the file MIME type is that of a JPEG" do
        uploader = MiniMagickUploader.new

        upload_file(uploader, fake_png_image)

        expect(Piet).to receive(:optimize_jpg).with(uploader.current_path, {})

        uploader.optimize
      end
    end
  end
end
