#!/bin/bash
# Register Wazuh agent with manager automatically

MANAGER_IP="wazuh-manager"
AGENT_NAME="wazuh-agent"

docker exec wazuh-agent /var/ossec/bin/agent-auth -m $MANAGER_IP -p 1515 -A $AGENT_NAME
