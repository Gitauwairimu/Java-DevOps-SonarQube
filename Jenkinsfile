pipeline {
    agent any
   
    tools {
        maven 'localmaven' 
        }

    environment{
        REPO = 'gitauwairimu'
        TAG = 'staging'
        // REGISTRY = '<ip>:5000'

    }

    stages {
        stage("SCM checkout") {
            steps {
                // Get some code from a GitHub repository
                git branch: 'main', url: 'https://github.com/Gitauwairimu/Java-DevOps-SonarQube.git'
            }            
        }

        stage ('Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -t ${REPO}/app:${TAG} ./" 
                echo 'Build Image Completed'                
            }
        }

        stage('Docker Push') {
            steps {
                sh "docker push ${REPO}/app:${TAG}"                
            }
        }

        stage('Deploy Docker Container') {
            steps {
                ansiblePlaybook credentialsId: 'dev-server', disableHostKeyChecking: true, extras: '-e TAG=${TAG} -e ENV=${DEPLOY_TO} --tags hello1', installation: 'ansible', inventory: '/home/src/ansible-scripts/inventory.inv', playbook: '/home/src/ansible-scripts/docker-deployment.yml'
            }
        }
    
    //         stage('IaC terraform Server Provisioning') {
    //             steps {
    //                 withCredentials([[
    //                     $class: 'AmazonWebServicesCredentialsBinding', 
    //                     accessKeyVariable: 'AWS_ACCESS_KEY_ID', 
    //                     secretKeyVariable: 'AWS_SECRET_ACCESS_KEY',
    //                     credentialsId: 'circlecikey'
    //                 ]]) {
    //                     sh 'terraform init'
    //                     sh 'terraform apply -auto-approve -no-color'
    //                         }
    //         }
                            
    //   }
    }
}