pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('21267379-9c24-43d1-9b81-f8a009f23928') // Docker Hub credentials stored in Jenkins
        IMAGE_NAME = 'santhoshadmin/k8-node' // Docker Hub username and repository (without the full URL)
    }

    stages {
        stage('Checkout Code') {
            steps {
                git 'https://github.com/ssanthosh2k3/node-app.git' // GitHub repository URL
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build the Docker image using the Dockerfile in the repository
                    def dockerImage = docker.build("${IMAGE_NAME}:${env.BUILD_ID}")
                }
            }
        }

        stage('Test Docker Image') {
            steps {
                script {
                    // Run the Docker image to ensure it works in detached mode
                    def container = docker.image("${IMAGE_NAME}:${env.BUILD_ID}").run("-d -p 3000:3000")
                    // Optional: Wait for a moment to ensure the container is running
                    sleep(5) // Adjust sleep time as necessary
                    // Check if the container is running
                    sh "docker ps -q --filter 'id=${container.id}'" // Verify container is running
                }
            }
        }

        stage('Push Docker Image to Docker Hub') {
            steps {
                script {
                    // Push the built image to Docker Hub
                    docker.withRegistry('https://registry.hub.docker.com', DOCKERHUB_CREDENTIALS) {
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
