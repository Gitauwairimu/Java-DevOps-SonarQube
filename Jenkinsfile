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
        stage('CleanWorkspace') {
            steps {
                cleanWs()
            }
        }



        stage("SCM checkout") {
            steps {
                // Get some code from a GitHub repository
                git branch: 'main', url: 'https://github.com/Gitauwairimu/Java-DevOps-SonarQube.git'
            }            
        }

        stage ('Maven Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        // stage('Docker Build') {
        //     steps {
        //         sh "ls"
        //         sh "pwd" 
        //         sh "docker build -t ${REPO}/app:${TAG} ./" 
        //         echo 'Build Image Completed'                
        //     }
        // }

        // stage('Docker Push') {
        //     steps {
        //         // docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"
        //         sh "docker push ${REPO}/app:${TAG}"                
        //     }
        // }

        stage('AnsiblePlaybook for Docker Container') {
            steps {
                ansiblePlaybook credentialsId: 'ansiblekey', disableHostKeyChecking: true, installation: 'ansible', inventory: 'invent.txt', playbook: 'jnknsdocker.yml'
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