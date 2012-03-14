# OmniAuth Weibo OAuth2

Weibo OAuth2 Strategy for OmniAuth 1.0.

Read Weibo OAuth2 docs for more details: http://open.weibo.com/wiki/Oauth2

## Installing

Add to your `Gemfile`:

```ruby
gem 'omniauth-weibo-oauth2'
```

Then `bundle install`.

Or install it yourself as:

    $ gem install omniauth-weibo-oauth2

## Usage

`OmniAuth::Strategies::Weibo` is simply a Rack middleware. Read the OmniAuth 1.0 docs for detailed instructions: https://github.com/intridea/omniauth.

Here's a quick example, adding the middleware to a Rails app in `config/initializers/omniauth.rb`:

```ruby
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :weibo, ENV['WEIBO_KEY'], ENV['WEIBO_SECRET']
end
```

## Authentication Hash

Here's an example *Authentication Hash* available in `request.env['omniauth.auth']`:

```ruby
{
  :provider => 'weibo',
  :uid => '1234567890',
  :info => {
    :nickname => 'beenhero',
    :name => 'beenhero',
    :location => '浙江 杭州',
    :image => 'http://tp4.sinaimg.cn/1640099215/50/1287016234/1',
    :description => '移步twitter@beenhero',
    :urls => {  :Blog => 'http://beenhero.com'
                :Weibo => 'http://weibo.com/beenhero'
    },
  },
  :credentials => {
    :token => '2.00JjgzmBd7F...', # OAuth 2.0 access_token, which you may wish to store
    :expires_at => 1331780640, # when the access token expires (if it expires)
    :expires => true # if you request `offline_access` this will be false
  },
  :extra => {
    :raw_info => {
      ... # data from /2/users/show.json, check by yourself
    }
  }
}
```
*PS.* Built and tested on MRI Ruby 1.9.3

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Copyright (c) 2012 by Bin He

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.