# Inspect overall status
echo "
--------------------------Status of containers------------------------
"
docker ps --filter health=unhealthy

echo " 
----------------------------Elasticsearch cluster health----------------------
"
# Elasticsearch cluster health
curl http://localhost:9200/_cluster/health?pretty


echo "
----------------------------Kibana status----------------------
"
# Kibana status
curl -s http://localhost:5601/api/status | grep -Po '"overall":{"level":"\K[^"]+'

