#!/bin/bash

# Install bundler version based on Gemfile.lock version
gem install bundler -v $(grep -A 1 'BUNDLED WITH' -i Gemfile.lock | grep -v 'BUNDLED WITH' | sed 's/ //g')

# Install gems
bundle install --jobs 10

# Set awscli binary in path
export PATH=`echo $PATH:/root/.local/bin`

# Run soyuz with all passed parameters
soyuz $@
