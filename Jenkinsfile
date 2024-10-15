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
        
        stage('Get Commit ID') {
            steps {
                script {
                    // Retrieve the commit hash of the current build
                    COMMIT_HASH = sh(
                        script: 'git rev-parse --short HEAD', // Get the short version of the commit hash
                        returnStdout: true
                    ).trim()
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image and tag it with the commit hash and the build number
                    sh """
                    echo "Building Docker image..."
                    docker build -t ${IMAGE_NAME}:${COMMIT_HASH} -t ${IMAGE_NAME}:${env.BUILD_NUMBER} .
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
                        docker push ${IMAGE_NAME}:${COMMIT_HASH}
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
