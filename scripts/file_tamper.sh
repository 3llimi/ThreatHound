#!/bin/bash
# Simulate file tampering by modifying a sensitive file

FILE="/tmp/testfile.txt"

echo "[*] Creating file $FILE"
touch $FILE

echo "[*] Modifying $FILE multiple times..."
for i in {1..10}; do
  echo "Tampering $i at $(date)" >> $FILE
  sleep 1
done

echo "[*] File tampering simulation done."
