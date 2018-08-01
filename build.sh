#!/usr/bin/env bash

export WEB_ROOT="docs"
export CHART_PATHS="incubator"


helm-create-chart-index(){
  local charts=$1
  helm repo index "${WEB_ROOT}/${charts}"
}

helm-package-chart(){
  local chart_path="$1"

  [[ $(helm lint ${chart_path} | grep -c '^[ERROR]') -ne 0 ]] && \
    echo "helm lint failed for ${chart_path}, skipping..." && \
    return

  helm package -d $chart_path $chart_path
  mkdir -p docs/$chart_path
  mv $chart_path/*.tgz docs/$chart_path/
}

pack-all-charts(){
  for charts in ${CHART_PATHS}; do
    for chart in $(ls $charts); do
      local chart_path="$charts/$chart"
      helm-package-chart $chart_path
    done
    helm-create-chart-index $charts
  done
}

pack-all-charts

