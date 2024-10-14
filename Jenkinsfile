pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('docker-hub-credentials')  // Docker Hub credentials stored in Jenkins
        IMAGE_NAME = 'your-dockerhub-username/your-app' // Replace with your Docker Hub username and repository
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/your-repo-url.git' // Replace with your GitHub repository URL
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile
                    docker.build("${IMAGE_NAME}:${env.BUILD_ID}")
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    // Run the Docker image to ensure it works
                    docker.image("${IMAGE_NAME}:${env.BUILD_ID}").run("-p 3000:3000")
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                        docker.image("${IMAGE_NAME}:${env.BUILD_ID}").push()
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs() // Clean workspace after the job is complete
        }
    }
}
