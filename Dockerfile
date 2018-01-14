FROM mkieboom/mapr-jumpbox-base
CMD /bin/bash


# Set the VNC password
ENV VNC_PW=mapr

# Switch to root user
USER root

# Install ssh client and nfs libraries
RUN yum install -y openssh-clients nfs-utils nfs-utils-lib && \
    yum clean all

# Add the mapr user
RUN groupadd -g 5000 mapr
RUN useradd -u 5000 -g 5000 mapr

# Set default password for user root and for user mapr
RUN echo -e "mapr\nmapr" | (passwd --stdin mapr)
RUN echo -e "mapr\nmapr" | (passwd --stdin root)

# Add mapr user to the list of sudoers
RUN echo "mapr	ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Add the MapR desktop background picture
ADD mapr_background.png /headless/.config/
ADD xfce4-desktop.xml /headless/.config/xfce4/xfconf/xfce-perchannel-xml

## switch back to default user (mapr)
USER mapr

# docker build -t mkieboom/mapr-jumpbox .

# docker run -it --privileged -p 5901:5901 -p 80:6901 mkieboom/mapr-jumpbox /bin/bash

