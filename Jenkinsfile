pipeline {
    agent any

    environment {
        GITHUB_CREDENTIALS_ID = 'github-credentials'
        REPO_URL = 'https://github.com/Hari9602/VulnRadar.git'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git credentialsId: GITHUB_CREDENTIALS_ID, branch: 'main', url: REPO_URL
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t vulnscanner:latest .'
                }
            }
        }

        stage('Run Container') {
            steps {
                script {
                    sh 'docker run --name vulnscanner -d vulnscanner:latest'
                }
            }
        }

        stage('Push Docker Image to GitHub Container Registry') {
            steps {
                script {
                    sh 'echo $GITHUB_PAT | docker login ghcr.io -u Hari9602 --password-stdin'
                    sh 'docker tag vulnscanner ghcr.io/hari9602/vulnscanner:latest'
                    sh 'docker push ghcr.io/hari9602/vulnscanner:latest'
                }
            }
        }

        stage('Cleanup') {
            steps {
                script {
                    sh 'docker stop vulnscanner || true'
                    sh 'docker rm vulnscanner || true'
                    sh 'docker rmi vulnscanner:latest || true'
                }
            }
        }
    }
}
