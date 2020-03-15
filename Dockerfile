FROM ubuntu:latest

# Install cron
RUN apt-get update
RUN apt-get install -y cron
RUN apt-get install -y curl
RUN apt-get install -y busybox-syslogd

# Add crontab file in the cron directory
ADD simple-crontab /etc/cron.d/simple-crontab

# Add shell script and grant execution rights
ADD script.sh /script.sh
RUN chmod +x /script.sh

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/simple-crontab

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD echo Start... >> /var/log/cron.log &&  \
    syslogd && \
    cron && \
    tail -f /var/log/cron.log

