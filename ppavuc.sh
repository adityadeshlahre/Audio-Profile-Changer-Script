#!/bin/bash

list_bluetooth_cards() {
    pactl list cards short | grep bluez_card | awk '{print $2}'
}

change_profile() {
    local card=$1
    local profile=$2
    pactl set-card-profile "$card" "$profile"
}

DEVICE=$(list_bluetooth_cards | dmenu -i -l 10 -p "Select Bluetooth device:")

if [ -z "$DEVICE" ]; then
    echo "No Bluetooth device selected."
    exit 1
fi

PROFILES="a2dp-sink\nheadset-head-unit-msbc"
PROFILE=$(echo -e "$PROFILES" | dmenu -i -l 10 -p "Select profile:")

if [ -z "$PROFILE" ]; then
    echo "No profile selected."
    exit 1
fi

change_profile "$DEVICE" "$PROFILE"

echo "Profile of $DEVICE changed to $PROFILE."
