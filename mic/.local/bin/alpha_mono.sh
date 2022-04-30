#!/bin/sh
if ! pactl list sources | grep -q alpha_mono; then
  pacmd load-module module-remap-source source_name=alpha_mono master=alsa_input.usb-Focusrite_Scarlett_2i2_USB_Y8AQQ2H1BCEE5D-00.analog-stereo channels=2 channel_map=mono,mono
  pacmd set-default-source alpha_mono
fi
