#!/bin/bash

RESPONSE_FILE="/tmp/qs-sudo-response"
rm -f "$RESPONSE_FILE"

qs ipc call password-input open 2>/dev/null

for i in $(seq 1 500); do
    if [ -f "$RESPONSE_FILE" ] && [ -s "$RESPONSE_FILE" ]; then
        cat "$RESPONSE_FILE"
        rm -f "$RESPONSE_FILE"
        exit 0
    fi
    if [ $i -gt 20 ] && [ -f "$RESPONSE_FILE" ] && [ ! -s "$RESPONSE_FILE" ]; then
        rm -f "$RESPONSE_FILE"
        exit 1
    fi
    sleep 0.1
done

rm -f "$RESPONSE_FILE"
exit 1
