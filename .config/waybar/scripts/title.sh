#!/bin/bash

~/.local/bin/ristate -w >& /tmp/river-window &

while true; do
cat /tmp/river-window | sed 's/title/text/'
done
