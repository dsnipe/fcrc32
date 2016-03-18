# Fast CRC32

## Description:

**It's just an experiment. Use it on your own risk**

Native eextension for CRC32 calculation.

It should be fast CRC32 implementation. But now it's slower than even `Zlib`.

## Features/Problems:

Now it uses simplified version of Slice16 implementation of CRC32 algorithm.


## Install:

Put it in your `Gemfile`:

```ruby
gem 'fcrc32', github: 'dsnipe/fcrc32'
```

And then `bund1le install`

## Synopsis:

_API is under heavy development._

Calculate CRC32 for a string:

```ruby
FCrc32.calculate('string')
```

Calculate CRC32 for a file:

```ruby
FCrc32.file('paht/to/file')
```

Same as above, but chunk file by pieces (slower, but memory saver):

```ruby
FCrc32.chunked_file('path/to/file', size_in_bytes)
```

By default size for chunks is 1024 bytes, so second argument could be omitted.

## Developers:

After checking out the source, run:

```sh
  $ bundle install
  $ rake test:dummy
  $ rake test
```

`rake test:dummy` task creates dummy file of specific size. By default it is 5Mb. 
It's possible to create a file with any size, using environment variable `SIZE`.

For benchmarks, run: 

```sh
  $ rake bench
```

## Credits:

* [Great C/C++ CRC32 library](http://create.stephan-brumme.com/crc32/)
* [The search for a faster CRC32 Blog post](https://blog.fastmail.com/2015/12/03/the-search-for-a-faster-crc32/)


## License:

(The MIT License)

Copyright (c) 2016 

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
