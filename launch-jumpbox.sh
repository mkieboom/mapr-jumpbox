#!/bin/bash

# Add the mapr user
groupadd -g $MAPR_CONTAINER_GID $MAPR_CONTAINER_GROUP
useradd -u $MAPR_CONTAINER_UID -g $MAPR_CONTAINER_GID $MAPR_CONTAINER_USER

# Set default password for user root and for user mapr
echo ENV"mapr\nmapr" | (passwd --stdin $MAPR_CONTAINER_USER)
echo ENV"mapr\nmapr" | (passwd --stdin root)

# Add mapr user to the list of sudoers
echo "$MAPR_CONTAINER_USER	ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Remove the firefox shortcut
rm -rf /headless/Desktop/firefox.desktop

# Set chrome launch page to mapr.com
sed -ie "s|Exec=chromium-browser %U|Exec=chromium-browser http://www.mapr.com|g" /headless/Desktop/chromium-browser.desktop
rm -rf /headless/Desktop/chromium-browser.desktope

# Launch terminal to keep the container alive
/bin/bash