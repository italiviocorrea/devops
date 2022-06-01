FROM alpine:3.16

MAINTAINER Italivio Correa <italiviocorrea@gmail.com>

ENV TMZ_LOCATION=America \
    TMZ_NAME=Campo_Grande \
    LANG='pt_BR.UTF-8'  \
    LANGUAGE='pt_BR.UTF-8' \
    LC_ALL='pt_BR.UTF-8'


# https://github.com/Yelp/dumb-init
# Runs "/usr/bin/dumb-init -- /my/script --with --args"
RUN apk add --no-cache dumb-init

ENTRYPOINT ["/usr/bin/dumb-init", "--"]

    
