#!/usr/bin/env bash

OUTPUT="eDP-1"

enabled=$(wlr-randr --json | jq -r --arg name "$OUTPUT" \
  '.[] | select(.name == $name) | .enabled')

if [ "$enabled" = "true" ]; then
    wlr-randr --output "$OUTPUT" --off
else
    wlr-randr --output "$OUTPUT" --on
fi
