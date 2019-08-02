Piet
======

[![Build Status](https://secure.travis-ci.org/albertbellonch/piet.png)](http://travis-ci.org/albertbellonch/piet)

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


Easy installation of binaries
------------------------------

While install binaries (like optipng, jpegoptim) is not a rocket science, it can be hard (or even impossible) for some people. Thinking on this a gem called [piet-binary](https://github.com/loureirorg/piet-binary) was created with theses binaries packed.
This is a good approach if you are using Heroku as your host provider, or if you are lazy or impatient ;)

After install piet, just install piet-binary and add to your Gemfile (if you are using Rails):
```bash
gem install piet-binary
```

And in your Gemfile
```ruby
gem 'piet'
gem 'piet-binary'
```

*PS 1: it's optional to call piet in your Gemfile, because piet-binary already do this. The same is valid to install the gem via command-line: just install the piet-gem and it will install the piet for you.*

*PS 2: don't forget to call 'bundle install' if you are using Rails*


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

Not that this will work not by just using the file extension, but by
MIME type detection, which should be more reliable.

The options are:

* **verbose**: Whether you want to get the output of the command or not. It is interpreted as a Boolean value. Default: false.

* **quality**: Adjust the output compression for JPEGs. Valid values are any integer between 0 and 100 (100 means no compression and highest quality). Default: 100

* **level**: Adjust the optimization level for PNGs. Valid values are any integer between 0 and 7 (7 means highest compression and longest processing time). Default: 7

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

To use custom options in the optimization:

```ruby
class ImageUploader < CarrierWave::Uploader::Base
  ...
  # To pass 1 hash as 1 argument
  # It needs to be put in an array
  # So in this example the actual call will look like:
  # ```
  # optimize({quality: 90, level: 7})
  # ```
  process optimize: [{quality: 90, level: 7}]
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

would optimize those PNG, GIF and JPEG files but output nothing.

* Optimizing PNG/GIF and getting feedback

```ruby
Piet.optimize('/my/wonderful/pics/piggy.png', :verbose => true)
```

would optimize that PNG/GIF file and output something similar to this one:

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

* Add SVG optimization
* Leave testing files out of the bundled gem
* Binary tool for optimizing a file
* Add some testing!

Changelog
---------

* v.0.2.6 Strip metadata for PNGs (same way we do with JPEGs) thanks to @PikachuEXE.
* v.0.2.5 Improved CI coverage & dropped support for Ruby 1.9
* v.0.2.4 Fixed Gemfile issues!
* v.0.2.3 More efficient treatment of open files thanks to @lavrovdv.
* v.0.2.2 Lighter gem weight (to be improved in the future).
* v.0.2.1 More reliable file type detection, by not using the extension but the MIME type. Thanks to @jewlofthelotus! Also, the Carrierwave
extension is now compatible with RMagick thanks to @YoranBrondsema.
* v.0.2.0 Users of the gem can now use piet-binary gem, and bug with filenames containing spaces, parentheses and some other characters is solved too, thanks to @loureirorg. Requiring png_quantizator when it's due, thanks to @jayzes. Finally, specifying the gem version due to @jigfox interest.
* v.0.1.3 Use png_quantizator gem instead of the own implementation.
* v.0.1.2 Fixed some problems with missing processing, thanks to @lentg.
* v.0.1.1 Added support for GIFs. Added an extra option to use pngquant (thanks @rogercampos). Solved problems with Carrierwave >= 0.6 (thanks @mllocs and @huacnlee).
* v.0.1.0 Optimization of PNGs and JPEGs, including an integration with Carrierwave
