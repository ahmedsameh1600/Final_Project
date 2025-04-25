# Final Project
# Ahmed Sameh Sobhy
#ahmedsameh1600@gmail.com


This repository contains the code and resources for my **Final Project**. The project demonstrates how to build and deploy a web application using Docker, Jenkins, Ansible, and other modern tools. It includes an automated CI/CD pipeline managed by Jenkins for continuous integration and deployment.

## Features

- **Dockerized Web Application**: The application is packaged into Docker containers to ensure consistency across different environments.
- **CI/CD Pipeline with Jenkins**: Jenkins automates the build, test, and deployment of the application, ensuring that any updates or changes go through a seamless process.
- **Automated Deployment with Ansible**: Ansible playbooks are used to automate the setup, configuration, and deployment process of the application, including setting up Prometheus, Grafana, and Node Exporter.

## Table of Contents

1. [Prerequisites](#prerequisites)
2. [Installation](#installation)
3. [Jenkins Setup](#jenkins-setup)
4. [Usage](#usage)
5. [Running the Application](#running-the-application)
6. [Troubleshooting](#troubleshooting)
7. [License](#license)

## Prerequisites

Before you begin, ensure you have the following tools installed:

- **Docker**: For containerization and managing application instances.
  - Installation guide: [Docker Installation](https://docs.docker.com/get-docker/)
- **Ansible**: For automating infrastructure management and deployment.
  - Installation guide: [Ansible Installation](https://docs.ansible.com/ansible/latest/installation_guide/index.html)
- **Jenkins**: For setting up the CI/CD pipeline to automate build and deployment processes.
  - Installation guide: [Jenkins Installation](https://www.jenkins.io/doc/book/installing/)

## Installation

1. **Clone the Repository**:
   Clone the repository to your local machine:
   ```bash
   git clone https://github.com/ahmedsameh1600/Final_Project.git
   cd Final_Project
   ```

2. **Build Docker Image**:
   Build the Docker image for the web application.

3. **Push to Docker Hub** :
   If you want to push the image to Docker Hub, you need to authenticate and push the image.

4. **Set Up the Docker Network** (Optional but recommended):
   Create a custom Docker network if your project requires it.

5. **Run the Application**:
   Run the Docker container and bind the ports.

## Jenkins Setup

1. **Set Up Jenkins for CI/CD**:
   - Install Jenkins on your machine or use a Jenkins server.
   - Install Docker and Ansible on the Jenkins machine.
   - Create a Jenkins pipeline project and connect it to this GitHub repository.
   
2. **Jenkins Pipeline Configuration**:
   Below is an example of the **Jenkinsfile** that automates the Docker build, test, push, and deployment process using Ansible.

   ### Jenkinsfile:
   ```groovy
   pipeline {

       agent any

       environment {
           DOCKERHUB_CREDENTIALS = credentials('abc7602b-e36c-4d32-aa00-5a69f9f6c66b')
       }

       stages {

           stage('Build Maven') {
               steps {
                   echo '🔧 Building the application...'
                   sh 'chmod +x mvnw'
                   sh './mvnw clean package'
               }
           }

           stage('Test') {
               steps {
                   echo '🧪 Testing the application...'
                   sh './mvnw test'
               }
           }

           stage('Build Docker Image') {
               steps {
                   echo '🏗️ Building Docker image...'
                   sh 'docker build -t <your-docker-username>/final_project .'
               }
           }

           stage('Login to DockerHub') {
               steps {
                   echo '🔐 Logging into DockerHub...'
                   sh '''
                       set -e
                       echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                   '''
               }
           }

           stage('Push Docker Image') {
               steps {
                   echo '🚀 Pushing Docker image to DockerHub...'
                   sh 'docker push <your-docker-username>/final_project'
               }
           }

           stage('Build & Push using Ansible & Run Prometheus, Grafana, Node Exporter') {
               steps {
                   echo '🚀 Running Ansible playbook...'
                   sh 'ansible-playbook ansible-playbook.yml'
               }
           }
       }

       post {
           always {
               echo '🔚 Logging out from Docker...'
               sh 'docker logout || true'
           }

           success {
               slackSend(channel: '#your-channel', message: "Build and deployment successful!")
           }

           failure {
               slackSend(channel: '#your-channel', message: "Build or deployment failed!")
           }
       }
   }
   ```

3. **Configure Jenkins Credentials**:
   - Set up DockerHub credentials in Jenkins (`abc7602b-e36c-4d32-aa00-5a69f9f6c66b` in this example) for secure authentication.

4. **Jenkins Pipeline Triggers**:
   You can set up Jenkins to automatically trigger the pipeline when changes are pushed to GitHub or on a scheduled basis.

---

## Usage

Once the application is up and running, you can access it by visiting:

```
http://localhost:8089
```

This will load the web application running on port `8089`.

---

## Running the Application


1. **Start Services**:
   Use Docker Compose to start the application and its dependencies.

2. **Stop Services**:
   Use Docker Compose to stop the application and its dependencies.

---

## Troubleshooting

### Common Issues:

1. **Docker Network Not Found**:
   If you receive a `network not found` error when trying to run the container, ensure that the Docker network exists.

2. **Permission Denied to Docker Daemon**:
   If you encounter permission errors while interacting with Docker, ensure that your user is added to the `docker` group to have proper permissions.

---

## License

This project is licensed under the **Apache-2.0 License** - see the [LICENSE](LICENSE) file for details.

---

### Contributions

If you’d like to contribute to this project, feel free to fork the repository, create a new branch, and submit a pull request. Please ensure that your code follows the [coding standards](#) and passes all the necessary tests.
```

---

This version of the **README** now includes the **Jenkins pipeline** and other relevant information from your GitHub repository. It provides a comprehensive guide for setting up and running your project.

Let me know if you need further adjustments! 
