#!/bin/sh

# The $SELECTED variable is available for space components and indicates if
# the space invoking this script (with name: $NAME) is currently selected:
# https://felixkratz.github.io/SketchyBar/config/components#space----associate-mission-control-spaces-with-an-item

source "$CONFIG_DIR/colors.sh" # Loads all defined colors

# if [ $SELECTED = true ]; then
#   sketchybar --set $NAME background.drawing=on \
#                          background.color=$ACCENT_COLOR \
#                          label.color=$BAR_COLOR \
#                          icon.color=$BAR_COLOR
# else
#   sketchybar --set $NAME background.drawing=off \
#                          label.color=$ACCENT_COLOR \
#                          icon.color=$ACCENT_COLOR
# fi

# make sure it's executable with:
# chmod +x ~/.config/sketchybar/plugins/aerospace.sh

if [ "$1" = "$FOCUSED_WORKSPACE" ]; then
    sketchybar --set $NAME background.drawing=on
else
    sketchybar --set $NAME background.drawing=off
fi
