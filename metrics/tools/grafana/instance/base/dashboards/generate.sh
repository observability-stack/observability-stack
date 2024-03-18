#!/bin/sh

# Generate GrafanaDashboard Custom Resources from json files and update Kustomize resource list.

workdir=json
root_out_dir=generated/$workdir

# Cleanup output folder
rm -rf "$root_out_dir"
mkdir -p "$root_out_dir"

# Initialize kustomize
echo "resources:" > "kustomization.yaml"

find $workdir -maxdepth 3 -type f -name '*.json' | awk '{print $0}' | while read -r dashboard_path 
do
    file=$(basename "$dashboard_path")
    datasource=$(dirname "$dashboard_path" | xargs dirname | xargs basename)
    folder=$(dirname "$dashboard_path" | xargs basename)

    out_dir="${root_out_dir}/${datasource}/${folder}"
    mkdir -p "$out_dir"

    # generate the custom resource file concatenating the template and json files and
    # susbstituting the CR name with the json filename and folder name with first level folder name
    sed 's/^/    /' "$dashboard_path" | cat "${workdir}/${datasource}/dashboard-template.yaml" - | sed "s/<NAME>/${file%.*}/g" | sed "s/<FOLDER>/${folder}/g" > "${out_dir}/${file%.*}.yaml"
    
    # output CR file path to kustomize
    echo "  - ${out_dir}/${file%.*}.yaml"
done >> "kustomization.yaml"
