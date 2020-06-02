FROM alpine:latest

MAINTAINER Quien Sabe "qs5779@mail.com"

RUN apk add syslog-ng openssl postfix logrotate

COPY postfix/main.cf postfix/master.cf /etc/postfix/
COPY entrypoint.sh /bin/

RUN mkdir -p /etc/postfix/sasl
RUN chmod a+x /bin/entrypoint.sh

EXPOSE 25

ENTRYPOINT ["/bin/entrypoint.sh"]
