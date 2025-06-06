#!/bin/bash

# Set volume path
VOL="/Volumes/Macintosh HD"

# Enable write access to the system volume
mount -uw "$VOL"

# Change to system library
cd "$VOL/System/Library" || exit 1

# Create directories to store inactive launch agents/daemons
mkdir -p LaunchAgents-inactive LaunchDaemons-inactive

# Move ManagedClient and mdmclient-related launch agents to inactive folder
mv -v LaunchAgents/com.apple.{ManagedClient,mdmclient}* LaunchAgents-inactive 2>/dev/null

# Move ManagedClient and mdmclient-related launch daemons to inactive folder
mv -v LaunchDaemons/com.apple.{ManagedClient,mdmclient}* LaunchDaemons-inactive 2>/dev/null

# Create an unsigned snapshot and bless it
bless --mount "$VOL" --create-snapshot --bootefi

# Disable authenticated root requirement
csrutil authenticated-root disable

# Reboot system
reboot
