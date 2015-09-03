#!/bin/bash

echo "[$SES_HOST]:$SES_PORT $SES_USER:$SES_SECRET" >> /etc/postfix/sasl_passwd
postmap hash:/etc/postfix/sasl_passwd
chown root:root /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
chmod 0600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
rm /etc/postfix/sasl_passwd
