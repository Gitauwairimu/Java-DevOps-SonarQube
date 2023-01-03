pipeline {
    agent any
   
    tools {
        maven 'localmaven' 
        }

    environment{
        REPO = 'Gitauwairimu'
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
            }
        }

        stage('Docker Push') {
            steps {
                sh "docker push ${REPO}/app:${TAG}"                
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