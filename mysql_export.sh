# Automatically create a dump file from MySql and compress then encrypt it.
# You should add it to your cron with something like:
# 01 12 * * * /path/to/your/mysql_export.sh
#!/bin/bash
now=$(date +"%Y_%m_%d")
filename=/opt/mysql/backup/backup_$now.sql
mysqldump -uYOUR_USERNAME -pYOUR_PASSWORD YOUR_TABLE > $filename
gzip $filename
gzippedfilename=$filename.gz
echo "YOUR_GPG_PASSWORD" | gpg -c --batch --passphrase-fd 0 $gzippedfilename
shred -zvn 0 $gzippedfilename # optional, depending of how paranoid you are
rm $gzippedfilename
echo "Created $gzippedfilename"
# You could add file sending (uploading) here. As long as the above password is not compromised, it could be even transferred via
# non encrypting channel, as gpg already encrypted the dump.
