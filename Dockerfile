FROM consul:0.8.3
MAINTAINER Tim Hartmann <tim.hartmann@runkeeper.com> (@paxindustria)

RUN \
  apk update && \
  apk -Uuv add groff less python py-pip && \
  pip install awscli && \
  apk --purge -v del py-pip && \
  rm /var/cache/apk/*
