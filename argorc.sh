#!/bin/bash

# This script include some common utils for argo.
# Add the line into the .bashrc in your home dir.
# curl https://raw.githubusercontent.com/yixinshi/kubescripts/r0.01/argorc -Lo /tmp/argorc && source /tmp/argorc && rm -f /tmp/argorc


# Print the last failed pod logs. Optionally you can supply the job name
argolog () {
  job_name=$1
  if [[ -z $job_name ]]; then
    job_name=`argo list|grep Failed|head -n 1|tr -s " " |cut -d" " -f 1`
  fi

  if [[ ! -z $job_name ]]; then
    argo get $job_name
    wk_name=`argo get $job_name|grep failed|tail -n 1|tr -s " " |cut -d" " -f 4`
    if [[ ! -z $wk_name ]]; then
      echo $wk_name
      kubectl logs -f $wk_name main
    else
      echo -n "no failed workflow found: "
      echo $job_name
    fi
  else
    echo "no failed job found..exit"
  fi
}

# Print the running pod logs. Optionally you can supply the job name
argorun () {
  job_name=$1
  if [[ -z $job_name ]]; then
    job_name=`argo list|grep Running|head -n 1|tr -s " " |cut -d" " -f 1`
  fi

  if [[ ! -z $job_name ]]; then
    argo get $job_name
    wk_name=`argo get $job_name|tail -n 1|tr -s " " |cut -d" " -f 4`
    if [[ ! -z $wk_name ]]; then
      echo $wk_name
      kubectl logs -f $wk_name main
    else
      echo -n "no running workflow found: "
      echo $job_name
    fi
  else
    echo "no running job found..exit"
  fi
}
