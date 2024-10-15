pipeline {
    agent any

    environment {
        IMAGE_NAME = 'santhoshadmin/nodeapp' // Name for the Docker image
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
                    echo "Building Docker image with tag: ${IMAGE_NAME}:${env.BUILD_ID}..."
                    docker build -t ${IMAGE_NAME}:${env.BUILD_ID} .
                    """
                }
            }
        }

        stage('Tag Docker Image') {
            steps {
                script {
                    // Tag the image as 'latest' for Docker Hub push
                    sh """
                    echo "Tagging the Docker image as latest..."
                    docker tag ${IMAGE_NAME}:${env.BUILD_ID} ${IMAGE_NAME}:latest
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
                        
                        echo "Pushing Docker image with tag: ${IMAGE_NAME}:${env.BUILD_ID}..."
                        docker push ${IMAGE_NAME}:${env.BUILD_ID}
                        
                        echo "Pushing Docker image with latest tag..."
                        docker push ${IMAGE_NAME}:latest
                        """
                    }
                }
            }
        }
    }

    post {
        always {
            cleanWs() // Clean workspace after the job is complete

            // Clean up unused Docker images
            script {
                sh """
                echo "Cleaning up unused Docker images..."
                docker image prune -af
                """
            }
        }
    }
}
