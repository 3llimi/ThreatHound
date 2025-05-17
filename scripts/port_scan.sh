#!/bin/bash
# Run an aggressive port scan on the target

TARGET_IP="localhost"

echo "[*] Starting nmap aggressive scan on $TARGET_IP..."
nmap -A -T4 $TARGET_IP

echo "[*] Nmap scan complete."
