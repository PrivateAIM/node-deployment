# Node Hub API Adapter
## Installation
### Updating the Environment Variables
The [deployment manifest](./hub-adapter-deployment.yaml) must have its environment variables updated to include the 
correct username and password for the HUB API. The other variables should be set to the correct values for the 
other node microservices, but can be manually changed if the k8s service names for these applications change.

### Updating Keycloak
This API validates tokens using Keycloak and must have a client assigned to it in keycloak. By default, the client 
name should be set to `hub-adapter` (see the `API_CLIENT_ID` env variable). Be sure to disable "client authentication" 
when creating the client in keycloak.