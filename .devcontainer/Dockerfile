FROM ruby:3.4.8-bookworm
RUN apt-get update \
 && apt-get install -y --no-install-recommends libvips42 postgresql-client \
 && rm -rf /var/lib/apt/lists/*
