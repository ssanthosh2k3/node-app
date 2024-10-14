pipeline {
    agent any

    environment {
        IMAGE_NAME = 'santhoshadmin/k8-node' // Your image name
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout the code from your GitHub repository
                git url: 'https://github.com/ssanthosh2k3/node-app.git', branch: 'main'
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using the Dockerfile in the repo
                    docker.build("${IMAGE_NAME}:${env.BUILD_ID}")
                }
            }
        }
    }

    post {
        always {
            cleanWs() // Clean workspace after job execution
        }
    }
}
