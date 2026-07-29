# Declarative Jenkins Pipeline

This pipeline builds the Flask application as a Docker image and pushes it to Docker Hub.
Image tags are based on Git tags or the `main`, `master` and `develop` branches.

It uses the Docker Hub account `schioppolone` and the Jenkins credential ID `dockerhub-credentials`.
