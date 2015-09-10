*/1 * * * *  cd /DATA/htdocs/sites/all/modules/civicrm && /usr/bin/php bin/cli.php  -j -sdefault -u {DRUPAL_MAILUSER} -p {DRUPAL_USER_PASSWORD}  -e Job -a process_mailing
*/15 * * * * /usr/bin/drush --root=/DATA/htdocs core-cron --yes
*/15 * * * * /usr/bin/drush -u 1 -r /DATA/htdocs civicrm-api job.execute auth=0 -y
