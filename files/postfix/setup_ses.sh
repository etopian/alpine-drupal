#!/bin/bash

echo "[$SES_HOST]:$SES_PORT $SES_USER:$SES_SECRET" >> /etc/postfix/sasl_passwd
postmap hash:/etc/postfix/sasl_passwd
chown root:root /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
chmod 0600 /etc/postfix/sasl_passwd /etc/postfix/sasl_passwd.db
cat /etc/postfix/main.cf.new >> /etc/postfix/main.cf
#rm /etc/postfix/sasl_passwd
