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
# .soyuz.yml in the app you want to deploy with soyuz
defaults:
  deploy_cmds:
    - 'opsicle deploy $SOYUZ_ENVIRONMENT'


environments:
  -
    production:
      deploy_cmds:
        -
          -
            display: "Deploy"
            cmd: "cap $SOYUZ_ENVIRONMENT deploy:rolling"
            default: true
          -
            display: "Deploy with Migrations"
            cmd: "cap $SOYUZ_ENVIRONMENT deploy:rolling_migrations"

      before_deploy_cmds:
        - accept-pull
        - tag-release
      after_deploy_cmds:
        - post-deploy-notes
  -
    staging: {}

```

## Usage

Interactive:
```bash
soyuz deploy
# => 1. production
# => 2. staging
1
# soyuz calls the before_deploy_cmds in the order they are defined
accept-pull
# script to merge your pull request grom github
# ...
tag-release
# script to build a new release for deployment
# ...
# soyuz call the deploy command for the given environment
1. Deploy
2. Deploy with Migrations
2
cap production deploy:rolling_migrations
# soyuz calls the after_deploy_cmds in the order they are defined
post-deploy-notes
# post all of your deploy notes somewhere useful
```

Non-interactive mode requires that you pass the environment argument and that all choices in your config have a default flagged.
```bash
soyuz --non_interactive deploy staging
```
## Building Docker Image
Run in the root directory of this repo:
`docker build . -t soyuz:latest`

## Running Soyuz in Docker Container
Create an alias in your ~/.bash_profile (or the like) with the below
`alias soyuz='docker run -it -v $(pwd)/.soyuz.yml:/.soyuz.yml -v $(pwd)/.opsicle:/.opsicle -v ~/.aws/credentials:/root/.aws/credentials -v ~/.ssh:/root/.ssh soyuz:latest'`
`source ~/.bash_profile`

## Deprecations

`:deploy_cmd` has be depricated in favor of `:deploy_cmds` to better
match the before_deploy_cmds and after_deploy_cmds symantics

## Contributing

1. Fork it ( http://github.com/sportngin/soyuz/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
