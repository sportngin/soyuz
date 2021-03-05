FROM ruby:2.2-slim

# Install necessary packages
RUN apt-get update -q && \
    apt-get install -qy \
    libncurses5-dev libncursesw5-dev gcc libffi-dev make ssh git

# Install pip3 and aws cli tools
RUN apt-get install python3-pip -y
RUN pip3 install awscli --upgrade --user
RUN pip3 install rsa
RUN pip3 install typing

# Install opsicle and symlink to soyuz opsicle path
RUN gem install opsicle
RUN ln -s /usr/local/bundle/bin/opsicle /usr/local/bin/opsicle

# Install soyuz
RUN gem install soyuz

# Copy entrypoint to image
COPY entrypoint.sh /entrypoint.sh

# Set working directory in prep for environment alias
WORKDIR /codebase

ENTRYPOINT ["/entrypoint.sh"]
