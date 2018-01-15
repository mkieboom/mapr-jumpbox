FROM mkieboom/mapr-jumpbox-base

# Defaults in case not provided using -e
ENV MAPR_CLUSTER demo.mapr.com
ENV MAPR_CLDB_HOSTS MAPRN01
ENV MAPR_CONTAINER_USER mapr
ENV MAPR_CONTAINER_GROUP mapr
ENV MAPR_CONTAINER_UID 5000
ENV MAPR_CONTAINER_GID 5000
ENV MAPR_MOUNT_PATH /mapr

# Set the VNC password
ENV VNC_PW=mapr

# Switch to root user
USER root

# Install ssh client and nfs libraries
RUN yum install -y openssh-clients nfs-utils nfs-utils-lib && \
    yum clean all && \
    rm -rf /var/cache/yum

# Add the MapR desktop background picture
ADD mapr_background.png /headless/.config/
ADD xfce4-desktop.xml /headless/.config/xfce4/xfconf/xfce-perchannel-xml

# Add a launch script creating the mapr group and user
ADD launch-jumpbox.sh /launch-jumpbox.sh
RUN sudo -E chmod +x /launch-jumpbox.sh

# Launch the script
CMD sudo -E /launch-jumpbox.sh
