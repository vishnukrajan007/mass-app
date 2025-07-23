pipeline {
    agent any

    environment {
        IMAGE_TAG = 'vishnukrajan007/myapp:latest'   // Your DockerHub image
        KUBECONFIG = '/home/ubuntu/.kube/config'     // Jenkins EC2 kubeconfig path
    }

    stages {
        stage('Deploy to EKS') {
            steps {
                sh '''
                echo "Deploying image ${IMAGE_TAG} to EKS..."
                export KUBECONFIG=${KUBECONFIG}
                kubectl set image deployment/massapp-deployment massapp-container=${IMAGE_TAG} --record
                '''
            }
        }
    }
}

