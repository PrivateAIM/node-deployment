# Installing via Helm
The Results Service uses the Minio subchart and installs all of its needed services using the community helm chart at 
https://github.com/minio/minio/tree/master/helm/minio. Before installing the Results Service helm chart, you must 
download the minio subchart using:
```bash
helm dependency update
```