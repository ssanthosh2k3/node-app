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
                    // Build the Docker image using the Dockerfile in the repository
                    docker.build("${IMAGE_NAME}:${env.BUILD_ID}")
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
