pipeline {
    agent any

    environment {
        IMAGE_NAME = 'santhoshadmin/k8-node' // Name for the Docker image
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout the code from the main branch
                git branch: 'main', url: 'https://github.com/ssanthosh2k3/node-app.git'
            }
        }
        
        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using shell commands
                    sh """
                    echo "Building Docker image..."
                    docker build -t ${IMAGE_NAME}:${env.BUILD_ID} .
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Use stored Docker Hub credentials to log in and push the image
                    withCredentials([string(credentialsId: 'Docker_hub', variable: 'DOCKER_HUB_TOKEN')]) {
                        sh """
                        echo "Logging into Docker Hub..."
                        echo "${DOCKER_HUB_TOKEN}" | docker login -u santhoshadmin --password-stdin
                        
                        echo "Tagging annd pushing the Docker image..."
                        docker tag ${IMAGE_NAME}:${env.BUILD_ID} ${IMAGE_NAME}:latest
                        docker push ${IMAGE_NAME}:${env.BUILD_ID}
                        docker push ${IMAGE_NAME}:latest
                        """
                    }
                }
            }
        }

        stage('Clean Up Docker Images') {
            steps {
                script {
                    // Remove the Docker images from the Jenkins server
                    sh """
                    echo "Removing local Docker images..."
                    docker rmi ${IMAGE_NAME}:${env.BUILD_ID} ${IMAGE_NAME}:latest || true
                    """
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
