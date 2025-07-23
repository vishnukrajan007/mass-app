pipeline {
    agent any

    environment {
        DOCKERHUB_CREDENTIALS = credentials('dockerhub-cred-id')
        GIT_CREDENTIALS = credentials('github-cred-id')
        KUBECONFIG = '/home/ubuntu/.kube/config'
        IMAGE_NAME = 'vishnukrajan007/myapp'
        IMAGE_TAG = 'latest'
    }

    stages {

        stage('Checkout Source') {
            steps {
                git(
                    url: 'https://github.com/vishnukrajan007/mass-app.git',
                    branch: 'main',
                    credentialsId: "${env.GIT_CREDENTIALS}"
                )
            }
        }

        stage('Build with Maven') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh """
                    docker build -t ${IMAGE_NAME}:${IMAGE_TAG} .
                """
            }
        }

        stage('Docker Login') {
            steps {
                sh """
                    echo "${DOCKERHUB_CREDENTIALS_PSW}" | docker login -u "${DOCKERHUB_CREDENTIALS_USR}" --password-stdin
                """
            }
        }

        stage('Push Docker Image') {
            steps {
                sh """
                    docker push ${IMAGE_NAME}:${IMAGE_TAG}
                """
            }
        }

        stage('Deploy to EKS') {
            steps {
                sh """
                    export KUBECONFIG=${KUBECONFIG}
                    kubectl set image deployment/massapp-deployment massapp-container=${IMAGE_NAME}:${IMAGE_TAG} --record
                """
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            node {
                sh 'docker logout'
            }
        }
        success {
            echo 'Deployment successful!'
        }
        failure {
            echo 'Deployment failed!'
        }
    }
}

