#!/bin/bash
snakemake --jobs 20 --use-conda \
--rerun-incomplete \
--latency-wait 120 \
--max-jobs-per-second 5 \
--max-status-checks-per-second 5 \
--cluster-config submit.2.json \
--cluster "sbatch --mem {cluster.mem} -J {cluster.name} --time {cluster.time} -p {cluster.p}"

# 1.standard
#--cluster "sbatch --mem {cluster.mem} -J {cluster.name} --time {cluster.time} -p {cluster.p}"

# 2.includes params:
## excludes node
#--cluster "sbatch --mem {cluster.mem} -J {cluster.name} --time {cluster.time} -p {cluster.p} {cluster.exclude}"

# 3.includes params:
### excludes node
### cpus-per-task
#--cluster "sbatch --mem {cluster.mem} -J {cluster.name} --time {cluster.time} -p {cluster.p} {cluster.exclude} --cpus-per-task {cluster.cpus-per-task}"
