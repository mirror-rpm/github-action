FROM alpine

LABEL "name"="RPM Mirror"
LABEL "description"=""
LABEL "maintainer"="Kitsune Solar <kitsune.solar@gmail.com>"
LABEL "repository"=""
LABEL "homepage"="https://pkgstore.github.io/"

COPY *.sh /
RUN apk add --no-cache bash curl git git-lfs

ENTRYPOINT ["/entrypoint.sh"]
