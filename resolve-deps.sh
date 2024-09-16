#!/usr/bin/env bash

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 || exit 1 ; pwd -P )"

contains_chart_yaml () {
  if [ -z $(find "$1" -maxdepth 1 -type f -regex '.*\Chart.y[a]ml') ]; then
    return 0
  else
    return 1
  fi
}

update_dependencies () {
  contains_chart_yaml "$1"

  if [ $? -eq 1 ]; then
      echo -n "updating chart dependencies of '$1' ... "
      cd "$1" && helm dependency update > /dev/null 2>&1

      if [ $? -ne 0 ]; then
          echo "FAILED"
      else
          echo "DONE"
      fi
  fi
}

for dir in $(find "${BASE_DIR}/flame" -type d); do
  update_dependencies "$dir"
done


