#!/bin/bash

/home/broms/SCRIPTS/BASH_SCRIPTS/synchro-configs-local.sh 2>&1| rg -v "sent|sending|total|Warning"
/home/broms/SCRIPTS/BASH_SCRIPTS/synchro-configs-remote.sh 2>&1| rg -v "sent|sending|total|Warning"
