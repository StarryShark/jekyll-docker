FROM alpine:3.7
LABEL maintainer="Sumit Goel <sumit@goel.pw>"

RUN echo 'export LC_ALL=C.UTF-8' >> /etc/profile && \
  echo 'export LANG=en_US.UTF-8' >> /etc/profile && \
  echo 'export LANGUAGE=en_US.UTF-8' >> /etc/profile && \
  source /etc/profile && \
  apk update && \
  apk add --clean-protected --no-cache \
          bash \
          tree \
          git \
          make \
          gcc \
          g++ \
          libcurl \
          zlib \
          zlib-dev \
          gsl \
          gsl-dev \
          ruby \
          ruby-dev \
          ruby-bundler \
          ruby-json \
          python \
          python-dev \
          nodejs \
          nodejs-npm && \
  rm -rf /var/cache/apk/*

RUN npm install -g firebase-tools && \
  gem install jekyll:3.7.3 \
              jekyll-feed:0.9.3 \
              jekyll-seo-tag:2.4.0 \
              jekyll-redirect-from:0.13.0 \
              jekyll-sitemap:1.2.0 \
              jekyll-paginate-v2:1.9.4 \
              classifier-reborn:2.2.0 \
              narray:0.6.1.2 \
              nmatrix:0.2.4 \
              gsl:2.1.0.3 \
              nokogiri:1.8.2 \
              html-proofer:3.8.0 \
              --no-document

WORKDIR /srv
