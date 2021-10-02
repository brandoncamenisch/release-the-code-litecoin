pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
            sh """
            docker-compose build
            docker-compose push
            """
            }
        }
        stage('Deploy') {
            steps {
            sh """
            kubectl apply -f statefulset.yaml
            """
            }
        }
    }
}