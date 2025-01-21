FROM alpine:3.21.2
ENV USERNAME="cbrown" \
    PASSWORD="Passw0rd" \
    AUTOLOGIN="false" \
    TZ="Europe/Helsinki"

COPY --chmod=700 ./entrypoint.sh /tmp/entrypoint.sh
COPY ./skel/ /etc/skel
COPY ./www/ /www
COPY ./lighttpd/lighttpd.conf /etc/lighttpd/lighttpd.conf

RUN apk update && \
    apk add --no-cache\
        tini\
        ttyd\
        lighttpd\
        tzdata\
        bash\
        nano\
        vim

ENTRYPOINT ["/sbin/tini", "--"]
CMD ["/tmp/entrypoint.sh"]

EXPOSE 8888
