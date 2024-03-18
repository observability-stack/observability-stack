# Grafana Dashboards

This folder contains all the code related to the development and deployment of Grafana Dashboards.

## Folder structure

All the dashboards are saved as JSON in the relative folder, organized per Datasource, then Grafana Folder.

```
json
|
|--- Thanos (datasource)
     |
     |--- Home (Grafana Folder)
```

In each datasource folder there is a `dashboard-template.yaml` file, which contains the `GrafanaDashboard` custom resource, specifying the datasource(s) for all the dashboards in that folder.

Finally, the `generated` folder contains all the final manifests ready to be deployed in Kubernetes.

### Usage

The easiest way to develop a dashboard is to create it in Grafana, then save it in the specific `json` folder and then launch the `generate.sh` script to create the relative manifest and insert it in Kustomize.

More in detail:
1. Create and develop your dashboard in Grafana
2. Select "Share" button
3. In `Export` tab, select `Export for sharing externally` (very important) and then `Save to file`
4. Check if the file contains content because it could happen that for compatibility reasons it is empty.
5. Delete or rename the already created dashboard to avoid conflicts with the locally saved one.
6. Launch `generate.sh`
7. Commit