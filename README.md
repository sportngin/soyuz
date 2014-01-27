# Soyuz

The trusty old deployment tool kit that glues all of your deployment tool chain together.

## Installation

Add this line to your application's Gemfile:

    gem 'soyuz'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install soyuz

## Configure

```yaml

default:
  deploy_cmd: 'opsicle deploy $ENVIORMENT'
  options:
    - migrate
    
environments:
  - 
    production:
      deploy_cmd: 'opsicle deploy --wait production'
      before_deploy_cmds:
        - accept-pull
        - tag-release
      after_deploy_cmds:
        - post-deploy-notes
  -
    staging: {}

```

## Usage

`bundle exec soyuz deploy`

## Contributing

1. Fork it ( http://github.com/sportngin/soyuz/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
