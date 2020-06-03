# Docker image wtfmta

This is my first attempt to move regular services to my new docker swarm
consisting of a variety of systems I have in my home. This is a minimalistic
postfix mta supporting relay to and external smtp server. In my case that is
a server on mail.com where my $10 annual fee allows me to send mail via their
smtp server. The only annoyance it that I can only send mail from my userid
(or one of my alias useris), hence the support for the ALLMAILFROM environment
variable. I have not used google's smtp service, but I read that it does the
rewrite of from automatically. Regardless this image should handle any standard
smtp service as a relay.

# ENVIRONMENT VARIABLES

|Name|Optional|Description|
|---|---|---|
|POSTFIX_HOSTNAME|No|hostname postfix uses in helo|
|POSTFIX_RELAY_HOST|No|host:port of relay host ex: [smtp.mail.com]:587|
|POSTFIX_RELAY_USER|No|username of relay host account|
|POSTFIX_RELAY_PASSWORD|No|password of relay host account|
|POSTFIX_ALLMAILFROM|Yes|from addresses, envelope and client rewitten to this address|
