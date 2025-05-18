#!/bin/bash


set -e

umask 0002

run_as_other_user_if_needed() {
  if [[ "$(id -u)" == "0" ]]; then
    exec chroot --userspec=1000 / "${@}"
  else
    exec "${@}"
  fi
}



elasticsearch_config_file="/usr/share/elasticsearch/config/elasticsearch.yml"
if grep -Fq  "#xpack features" "$elasticsearch_config_file";
then
  declare -A CONFIG_MAP=(
  [xpack.ml.enabled]=$XPACK_ML
  )
  for i in "${!CONFIG_MAP[@]}"
  do
    if [ "${CONFIG_MAP[$i]}" != "" ]; then
      sed -i 's/.'"$i"'.*/'"$i"': '"${CONFIG_MAP[$i]}"'/' $elasticsearch_config_file
    fi
  done
else
  echo "
#xpack features
xpack.ml.enabled: $XPACK_ML
 " >> $elasticsearch_config_file
fi


./config_cluster.sh

./load_settings.sh &


run_as_other_user_if_needed /usr/share/elasticsearch/bin/elasticsearch
