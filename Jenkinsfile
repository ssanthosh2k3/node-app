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
                    // Build the Docker image and tag it with the Jenkins build number
                    sh """
                    echo "Building Docker image..."
                    docker build -t ${IMAGE_NAME}:${env.BUILD_NUMBER} .
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
                        
                        echo "Tagging and pushing the Docker image..."
                        docker push ${IMAGE_NAME}:${env.BUILD_NUMBER}
                        """
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
