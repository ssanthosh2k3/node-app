pipeline {
    agent any 

    stages {
        stage('Checkout SCM') {
            steps {
                checkout scm
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    echo "Building Docker image with tag: santhoshadmin/nodeapp:41..."
                    sh 'docker build -t santhoshadmin/nodeapp:41 .'
                }
            }
        }
        stage('Tag Docker Image') {
            steps {
                script {
                    echo "Tagging the Docker image as latest..."
                    sh 'docker tag santhoshadmin/nodeapp:41 santhoshadmin/nodeapp:latest'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                script {
                    echo "Logging into Docker Hub..."
                    sh 'echo $DOCKER_HUB_TOKEN | docker login -u santhoshadmin --password-stdin'
                    echo "Pushing Docker image with tag: santhoshadmin/nodeapp:41..."
                    sh 'docker push santhoshadmin/nodeapp:41'
                    echo "Pushing Docker image with latest tag..."
                    sh 'docker push santhoshadmin/nodeapp:latest'
                }
            }
        }
    }
    
    post {
        always {
            cleanWs()
            sh 'docker image prune -af'
        }
    }
}
