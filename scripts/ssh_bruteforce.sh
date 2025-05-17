#!/bin/bash
# Simulate a basic SSH brute force attack on a target machine

TARGET_IP="localhost"   # or IP of your Wazuh agent

echo "[*] Starting SSH brute force simulation against $TARGET_IP..."

for i in {1..50}; do
  sshpass -p "wrongpassword" ssh -o StrictHostKeyChecking=no -o ConnectTimeout=2 user@$TARGET_IP exit
done

echo "[*] SSH brute force simulation complete."
