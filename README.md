# DevOps:java-web-app

## Author: Charles
## About: Java Application on CICD



![alt](https://www.google.com/url?sa=i&url=https%3A%2F%2Fdeveloper.ibm.com%2Ftutorials%2Fcicd-pipeline-with-jenkins-to-deploy-multi-arch-image-on-ocp-on-linuxone-and-x86%2F&psig=AOvVaw3WiQIbIIO1lQlcgCw4cQqF&ust=1674025877853000&source=images&cd=vfe&ved=0CBAQjRxqFwoTCJCHgeGGzvwCFQAAAAAdAAAAABAD)

## Technologies
- [x] Jenkins
- [x] SonarQube
- [x] Artifactory
- [x] Ansible
- [x] Docker
- [x] Slack

### Workflow
1. SonarQube analysis the code. A Quality gate condition applies.
2. A Maven make step produces a Jar file.
3. The Jar is used to make a docker image that is uploaded to a Artifactory as a private docker registry.
4. Ansible authenticates and pulls the image for Artifactory.
5. Ansible deploys the docker image.
6. Slack is integrated for alerting

> More code follows