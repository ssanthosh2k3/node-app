pipeline {
    agent any

    environment {
        IMAGE_NAME = 'santhoshadmin/k8-node' // Base name for the Docker image
        BUILD_TAG = 'nodeapp' // Custom tag name prefix
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
                    // Build the Docker image with the custom tag
                    sh """
                    echo "Building Docker image..."
                    docker build -t ${IMAGE_NAME}:${BUILD_TAG}-${env.BUILD_ID} .
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to Docker Hub and push the image with the custom tag
                    withCredentials([string(credentialsId: 'Docker_hub', variable: 'DOCKER_HUB_TOKEN')]) {
                        sh """
                        echo "Logging into Docker Hub..."
                        echo "${DOCKER_HUB_TOKEN}" | docker login -u santhoshadmin --password-stdin
                        
                        echo "Tagging and pushing the Docker image..."
                        docker tag ${IMAGE_NAME}:${BUILD_TAG}-${env.BUILD_ID} ${IMAGE_NAME}:latest
                        docker push ${IMAGE_NAME}:${BUILD_TAG}-${env.BUILD_ID}
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
                    docker rmi ${IMAGE_NAME}:${BUILD_TAG}-${env.BUILD_ID} ${IMAGE_NAME}:latest || true
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
