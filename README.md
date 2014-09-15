# Newegg

Newegg Marketplace API wrapper

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'newegg'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install newegg

## Usage

    client = Newegg::Client.new(app_key: 'your_app_key', access_token: 'your_access_token')
    client.order_details('1843243242343')

## Contributing

1. Fork it ( https://github.com/ryancheung/newegg/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
