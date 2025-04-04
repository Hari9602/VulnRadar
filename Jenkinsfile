pipeline {
    agent any

    environment {
        IMAGE_NAME = "vulnscanner"
        GITHUB_USER = "hari9602"
        GHCR_IMAGE = "ghcr.io/hari9602/vulnscanner:latest"
        DOCKERHUB_CREDS = credentials('github-credentials')
    }

    stages {
        stage('Clone Repository') {
            steps {
                git credentialsId: 'github-credentials', url: 'https://github.com/Hari9602/VulnRadar.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t vulnscanner:latest .'
            }
        }

        stage('Tag Docker Image for GHCR') {
            steps {
                sh 'docker tag ${IMAGE_NAME}:latest ${GHCR_IMAGE}'
            }
        }

        stage('Login to GHCR') {
            steps {
                sh 'echo ${DOCKERHUB_CREDS_PSW} | docker login ghcr.io -u ${DOCKERHUB_CREDS_USR} --password-stdin'
            }
        }

        stage('Push Docker Image to GHCR') {
            steps {
                sh 'docker push ${GHCR_IMAGE}'
            }
        }

        stage('Run Docker Container') {
            steps {
                sh 'docker run --rm ${IMAGE_NAME}:latest'
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            sh 'docker rmi ${IMAGE_NAME}:latest || true'
            sh 'docker rmi ${GHCR_IMAGE} || true'
        }
    }
}
