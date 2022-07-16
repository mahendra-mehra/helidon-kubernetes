#!/bin/bash
if [ $# -eq 0 ]
  then
    echo "No arguments supplied, you must provide the name of your department, e.g. Tims"
    exit -1 
fi
department=$1

if [ -z "$KUBERNETES_CLUSTERS_WITH_INSTALLED_SERVICES" ]
then
  export KUBERNETES_CLUSTERS_WITH_INSTALLED_SERVICES=0
fi

if [ "$KUBERNETES_CLUSTERS_WITH_INSTALLED_SERVICES" = 0 ]
then
  echo "No other clusters with shared services currently installed, will setup the department config file"
else
  echo "There are other clusters with the shared services already in place, no need to update the department config file"
  exit 0
fi

if [ $# -eq 1 ]
  then
    echo "Updating the stockmanager config to set $department as the department name."
    read -p "Proceed (y/n) ?"
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
      then
        echo OK, exiting
        exit 1
    fi
  else
    echo "Skipping stockmanager department set confirmation using $department as the department name"
fi
config=$HOME/helidon-kubernetes/configurations/stockmanagerconf/conf/stockmanager-config.yaml
temp="$config".tmp
echo "Updating the stockmanager config in $config to reset $department as the department name"
# echo command is "s/#  department: \"My Shop\"/  department: \"$department Shop\"/"
cat $config | sed -e "s/#  department: \"My Shop\"/  department: \"$department Shop\"/" > $temp
rm $config
mv $temp $config