FROM alpine:3.10

RUN adduser -S postsrsd \
    && apk add --no-cache postsrsd \
    && mkdir -p /etc/postsrsd/secrets \
    && chown postsrsd /etc/postsrsd/secrets

USER postsrsd

VOLUME /etc/postsrsd/secrets

# https://github.com/roehling/postsrsd/blob/1.6/postsrsd.c#L342
ENV SRS_DOMAIN change-me.tld
ENV SRS_SECRET /etc/postsrsd/secrets/list

# forward SRS lookup
EXPOSE 10001/tcp
# reverse SRS lookup
EXPOSE 10002/tcp

# > Cannot open file with secret: /etc/postsrsd/secrets/list
CMD touch "$SRS_SECRET" && postsrsd -l0.0.0.0 -e
