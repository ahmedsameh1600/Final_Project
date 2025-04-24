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

        stage('Login to DockerHub') {
            steps {
                echo '🔐 Logging into DockerHub...'
                sh '''
                    set -e
                    echo $DOCKERHUB_CREDENTIALS_PSW | docker login -u $DOCKERHUB_CREDENTIALS_USR --password-stdin
                '''
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
    }
}
