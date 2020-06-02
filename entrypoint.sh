#!/bin/sh

function start_postfix {
  /usr/libexec/postfix/master -w
}

# aparently alpine defaults to an ash shell so these should work
SASLUSER=${SMARTHOST_USER:-dunno@example.com}
SASLPWD=${SMARTHOST_PASSWORD:=drowssap}
MYHOSTNAME=${MAILNAME:-dsmtp.example.com}
RELAYHOST=${SMARTHOST_ADDRESS:-[smtp.mail.com]:587}
if [ -z "$MYDOMAIN" ]
then
  MYDOMAIN=`echo $MYHOSTNAME | cut -d '.' -f 2-`
fi
ALLFROM=${ALL_FROM:-${SASLUSER}}

sed -i -e "s/^myhostname =.*/myhostname = ${MYHOSTNAME}/" \
  -e "s/^mydomain =.*/mydomain = ${MYDOMAIN}/" \
  -e "s/^relayhost =.*/relayhost =${RELAYHOST}/" /etc/postfix/main.cf

echo "@localdomain.local $ALLFROM" >> /etc/postfix/generic
echo "@${MYDOMAIN} $ALLFROM" >> /etc/postfix/generic
echo "${RELAYHOST} ${SASLUSER}:${SASLPWD}" > /etc/postfix/sasl/sasl_secret
chown root:postfix /etc/postfix/sasl/sasl_secret
chmod 600 /etc/postfix/sasl/sasl_secret
postmap /etc/postfix/sasl/sasl_secret /etc/postfix/generic

start_postfix

while [ 1 -eq 1 ]
do
  sleep 120
  # TODO: check if postfix still running, start if not
  # TODO: once a day run logrotate
done

