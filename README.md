Piet
======

Description
-----------

Piet is a gem that optimizes an image stored in a file, and it has
integration with CarrierWave uploaders.

This gem is named after the minimalist Dutch painter [Piet Mondrian](http://en.wikipedia.org/wiki/Piet_Mondrian).

Installation
------------

This gem requires two image optimization utilities: **optipng** and
**jpegoptim**, available in various platforms such as Unix or Windows.
You can install them by following the instructions on each authors'
page:

* Installation for [optipng](http://optipng.sourceforge.net/)
* Installation for [jpegoptim](http://freecode.com/projects/jpegoptim)

After installing both utils, simply install the gem:

    gem install piet

Usage
-----

You simply require the gem

```ruby
require 'piet'
```

and then call the **optimize** method:

```ruby
Piet.optimize(path, opts)
```

The options are:

* **verbose**: Whether you want to get the output of the command or not. It is interpreted as a Boolean value. Default: false.

* **quality**: If you wanna add a compression, adjust the quality parameter. Valid values are any integer between 0 and 100 (100 means no compression and highest quality). Default: 100


CarrierWave integration
-----------------------

As stated before, Piet can be integrated into CarrierWave uploaders.
This way, you can optimize the original image or a version.

In order to do that, firstly add **piet** to your Gemfile:

```ruby
gem 'piet'
```

Then go to your CarrierWave uploader and include Piet's extension:

```ruby
class ImageUploader < CarrierWave::Uploader::Base
  ...
  include Piet::CarrierWaveExtension
  ...
end
```

And finally use Piet! For all the images:

```ruby
class ImageUploader < CarrierWave::Uploader::Base
  ...
  process :optimize
  ...
end
```

Or only for a version:

```ruby
class ImageUploader < CarrierWave::Uploader::Base
  ...
  version :normal do
    ...
    process :optimize
  end
  ...
end
```

Examples
--------

* Simply Optimizing

```ruby
Piet.optimize('/my/wonderful/pics/piggy.png')

Piet.optimize('/my/wonderful/pics/pony.jpg')
```

would optimize those PNG, GIF and JPEG files but ouput nothing.

* Optimizing PNG/GIF and getting feedback

```ruby
Piet.optimize('/my/wonderful/pics/piggy.png', :verbose => true)
```

would optimize that PNG/GIF file and ouput something similar to this one:

    ** Processing: piggy.png
    340x340 pixels, 4x8 bits/pixel, RGB+alpha
    Input IDAT size = 157369 bytes
    Input file size = 157426 bytes

    Trying:
      zc = 9  zm = 9  zs = 0  f = 1   IDAT size = 156966
      zc = 9  zm = 8  zs = 0  f = 1   IDAT size = 156932

    Selecting parameters:
      zc = 9  zm = 8  zs = 0  f = 1   IDAT size = 156932

    Output IDAT size = 156932 bytes (437 bytes decrease)
    Output file size = 156989 bytes (437 bytes = 0.28% decrease)

* Optimizing JPEG and getting feedback

```ruby
Piet.optimize('/my/wonderful/pics/pony.jpg', :verbose => true)
```

would optimize that JPEG file and ouput similar to this one:

    /my/wonderful/pics/pony.jpg 235x314 24bit JFIF  [OK] 15305 --> 13012 bytes (14.98%), optimized.

Pngquant
--------
You can use Piet to convert 24/32-bit PNG images to paletted (8-bit) PNGs. The conversion reduces file sizes significantly and preserves full alpha transparency.

Simply use Piet like this:
```ruby
Piet.pngquant('/a/path/where/you/store/the/file/to/convert')
```

Please note **you have to install the binary** in order to use the tool. Simply follow the instructions (and read more info about it) in [the official site](http://pngquant.org/).

Thanks to [@rogercampos](http://github.com/rogercampos) for providing the awesome **png_quantizator** gem, which you can find [here](https://github.com/rogercampos/png_quantizator).

TODO
----

* Binary tool for optimizing a file
* Add some testing!

Changelog
---------

* v.0.1.0 Optimization of PNGs and JPEGs, including an integration with Carrierwave
* v.0.1.1 Added support for GIFs. Added an extra option to use pngquant (thanks @rogercampos). Solved problems with Carrierwave >= 0.6 (thanks @mllocs and @huacnlee).
* v.0.1.2 Fixed some problems with missing processing, thanks to @lentg.
* v.0.1.3 Use png_quantizator gem instead of the own implementation.
