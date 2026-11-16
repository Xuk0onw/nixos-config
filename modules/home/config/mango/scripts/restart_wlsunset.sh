#!/usr/bin/bash

set +e

pkill -x wlsunset >/dev/null 2>&1 || true

nohup wlsunset -T 3501 -t 3500 >/dev/null 2>&1 &