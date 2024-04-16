# Installing via Helm
The Results Service uses the Minio subchart and installs all of its needed services using the community helm chart at 
https://github.com/minio/minio/tree/master/helm/minio. Before installing the Results Service helm chart, you must 
download the minio subchart using:
```bash
helm dependency update
```

A number of important values should be set for Minio including:
* rootUser and rootPassword (they can be set directly, but a secret should be used)
* `HUB__AUTH_USERNAME` and `HUB__AUTH_PASSWORD`
* replicas (currently set to 2)
* Requested memory (default is 1Gi)
* Size of reserved hard disk space (default is 1Gi)
