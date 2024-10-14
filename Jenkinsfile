pipeline {
    agent any

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout the repository
                git url: 'https://github.com/ssanthosh2k3/node-app.git', branch: 'main'

                // List the specific files we need
                sh '''
                    echo "Files in the workspace:"
                    ls -l app.js package.json styles.css
                '''
            }
        }
    }

    post {
        always {
            cleanWs() // Clean workspace after job execution
        }
    }
}
