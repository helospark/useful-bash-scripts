# Removes backups that are older than specified number of days from backup folder
# You could add it to cron to automate it
#!/bin/bash
find backup/* -mtime +5 -exec rm {} \;
