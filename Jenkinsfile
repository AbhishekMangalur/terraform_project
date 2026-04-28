pipeline {
    agent any

    stages {

        stage('Checkout') {
            steps {
                git 'https://github.com/AbhishekMangalur/terraform_project.git'
            }
        }

        stage('Terraform Init') {
            steps {
                sh 'cd terraform && terraform init'
            }
        }

        stage('Terraform Apply') {
            steps {
                sh 'cd terraform && terraform apply -auto-approve'
            }
        }

        stage('Helm Deploy') {
            steps {
                sh 'helm install nginx helm/nginx-chart || true'
            }
        }

        stage('Verify') {
            steps {
                sh 'kubectl get pods -A'
            }
        }
    }
}