#!/bin/bash
currentContext=`bash get-current-context.sh`
settingFile=$HOME/clusterSettings.$currentContext
if [ $# -lt 2 ]
  then
    echo "Missing arguments, you must provide the name of your department - in lower case and only a-z, e.g. tims, and the ingress controller IP address"
    exit -1
    
fi
namespace=$1
ip=$2
if [ $# -eq 2 ]
  then
    echo "setting up config in downloaded git repo using $namespace as the department name $ip as ther ingress controller IP address $currentContext is the current kubernetes context name"
    read -p "Proceed ? " -n 1 -r
    echo    # (optional) move to a new line
    if [[ ! $REPLY =~ ^[Yy]$ ]]
      then
        echo OK, exiting
        exit 1
    fi
  else
    echo "Skipping entire stack confirmation, setting up config in downloaded git repo using $namespace as the department name $ip as the ingress controller IP address $currentContext is the current kubernetes context name"
fi
cd $HOME/helidon-kubernetes/base-kubernetes
echo Setup namespace
bash ./create-namespace.sh $namespace
echo NAMESPACE=$namespace >> $settingFile
echo Creating tls store secret
bash $HOME/helidon-kubernetes/setup/kubernetes-labs/create-store-cert.sh $ip
bash ./create-services.sh
bash ./create-ingress-rules.sh
bash ./create-secrets.sh
bash ./create-configmaps.sh
cd ..
bash ./deploy.sh

bash $HOME/helidon-kubernetes/setup/kubernetes-labs/waitForServices.sh $ip