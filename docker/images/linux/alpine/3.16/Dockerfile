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

# nos seus containers execute as suas aplicações conforme o modelo abaixo:
# CMD ["bash", "-c", "do-some-pre-start-thing && exec my-server"]
# CMD ["/my/script", "--with", "--args"]
# aonde o script pode ser assim:
# #!/usr/bin/dumb-init /bin/sh
# my-web-server &  # launch a process in the background
# my-other-server  # launch another process in the foreground
