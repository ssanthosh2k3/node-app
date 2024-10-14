pipeline {
    agent any

    environment {
        IMAGE_NAME = 'santhoshadmin/k8-node' // Name for the Docker image
        DOCKER_CREDENTIALS_ID = 'Docker_hub'  // Docker credentials stored in Jenkins
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
                    sh '''
                    echo "Building Docker image..."
                    docker build -t ${IMAGE_NAME}:${env.BUILD_ID} .
                    '''
                }
            }
        }
        
        stage('Push Docker Image') {
            steps {
                script {
                    // Log in to Docker Hub using Jenkins credentials
                    withCredentials([string(credentialsId: "${DOCKER_CREDENTIALS_ID}", variable: 'DOCKERHUB_PASS')]) {
                        sh '''
                        echo "Logging in to Docker Hub..."
                        echo "$DOCKERHUB_PASS" | docker login -u santhoshadmin --password-stdin

                        echo "Tagging the image..."
                        docker tag ${IMAGE_NAME}:${env.BUILD_ID} ${IMAGE_NAME}:latest

                        echo "Pushing the image to Docker Hub..."
                        docker push ${IMAGE_NAME}:${env.BUILD_ID}
                        docker push ${IMAGE_NAME}:latest
                        '''
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
