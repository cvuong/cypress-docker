#!/bin/bash
echo "Buildkite ENV"
echo "BUILDKITE_PARALLEL_JOB: $BUILDKITE_PARALLEL_JOB"
echo "BUILDKITE_PARALLEL_JOB_COUNT: $BUILDKITE_PARALLEL_JOB_COUNT"
printf "\n\n"

cypress_tests=($(find cypress/integration -type f -name "*.js" | sort -V))
job_tests=()
for i in "${!cypress_tests[@]}"; do
    remainder=$((($i + $BUILDKITE_PARALLEL_JOB) % $BUILDKITE_PARALLEL_JOB_COUNT))
    if [ $remainder -eq 0 ]; then
      job_tests+=(${cypress_tests[$i]})
    fi
done

cypress_spec=$(IFS=,; echo "\"${job_tests[*]}\"")
npm install
$(npm bin)/cypress install
command="$(npm bin)/cypress run --spec $cypress_spec"
# Is this safe?
eval $command