FROM alpine:3.3

# https://pkgs.alpinelinux.org/package/v3.3/main/x86/ruby-mysql2
# https://pkgs.alpinelinux.org/package/v3.4/main/x86/ruby-mysql2 ---> 404

RUN apk update && apk upgrade && \
  apk --update add --virtual build-dependencies build-base ruby-dev && \
  apk --update add openssl ca-certificates postgresql-dev ruby ruby-json ruby-bigdecimal ruby-mysql2 mariadb-dev && \
  gem install mysql2 -v 0.5.1 --no-ri --no-rdoc && \
  gem install pg -v 0.18.4 --no-ri --no-rdoc && \
  gem install activerecord-mysql-awesome --no-ri --no-rdoc && \
  gem install ridgepole -v 0.7.2 --no-ri --no-rdoc && \
  gem cleanup && \
  apk del build-dependencies && \
  rm /usr/lib/libmysqld* && \
  rm -rf /var/cache/apk/*

WORKDIR /work

ENTRYPOINT ["ridgepole"]
