pipeline {
    agent any
   
    tools {
        maven 'localmaven' 
        }

    environment{
        CI = true
        REPO = 'gitauwairimu'
        TAG = 'staging'
        // REGISTRY = '<ip>:8082'
        artifactory_credential = credentials('repotoken')
        

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

        


        // stage('SonarQube analysis') {
        //     steps {
        //         withSonarQubeEnv(installationName: 'sonarServer') {
        //             sh "./mvnw clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar"
        //             // sh "mvn sonar:sonar"
        //         }                
        //     }
        // }

        // stage("Quality Gate"){
        //     steps {
        //         script {
        //         def qualitygate = waitForQualityGate()
        //         sleep(2)
        //         if (qualitygate.status != "OK") {
        //             waitForQualityGate abortPipeline: true
        //         }
        //         }
        //     }
        // }

        // stage("Quality Gate"){        
        //     steps {
        //         timeout(time: 2, unit: 'MINUTES'){
        //             waitForQualityGate abortPipeline: true
        //         }
        //     }
        // }

        stage ('Maven Build') {
            steps {
                sh 'mvn clean package'
            }
        }

        stage('Docker Build') {
            //  agent {
            //      docker {image 'maven:3.8.7-openjdk-18'}
            // }
            steps {
                sh "docker build -t myimage:${TAG}-${BUILD_NUMBER} ./"
                sh "docker images"
                sh "docker tag myimage:${TAG}-${BUILD_NUMBER} beem.jfrog.io/docker-local/mavenenterprise:${TAG}-${BUILD_NUMBER}" 
                sh "docker images"
                echo 'Build Image Completed'                
            }
        }

        // stage('Docker Push') {
        //     steps {
        //         sh 'docker login -u="$DOCKER_USERNAME" -p="$DOCKER_PASSWORD"'
        //         sh "docker push ${REGISTRY}/${REPO}/app:${TAG}"                
        //     }
        // }
        stage('Docker Push') {
            steps {
                sh 'docker login -ugitauwairimu@gmail.com -p ${artifactory_credential} beem.jfrog.io'
                // docker login -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD}"
                // docker login -u="${DOCKER_USERNAME}" -p="${DOCKER_PASSWORD} beem.jfrog.io"
                sh "docker push beem.jfrog.io/docker-local/mavenenterprise:${TAG}-${BUILD_NUMBER}"
           
            }
        }

        // stage('Pushing Docker Image to Jfrog Artifactory') {
        //     steps {
        //         script {
        //             docker.withRegistry('https://beem.jfrog.io', 'artifactory-credential') {
        //                 docker.image("docker-local/mavenenterprise:${TAG}").push()                        
        //             }
        //         }
        //     }
        // }

        // stage('Docker Push to Artifactory') {
        //     steps {
        //         container('docker'){
        //             script {
        //             docker.withRegistry( 'https://beem.jfrog.io', 'artifactory-credential' ) {
        //                 sh "docker push beem.jfrog.io/docker-local/mavenenterprise:${TAG}"
        //             }
        //         }
        //         }
        //     }
        // }
        
        // stage('Docker Build') {
        //     steps {
        //         script {
        //             docker.build("default-docker-local/hello-world:${TAG}")
        //         }
        //     }
        // }



        stage('AnsiblePlaybook for Docker Container') {
            steps {
                ansiblePlaybook credentialsId: 'radikey', disableHostKeyChecking: true, installation: 'ansible', inventory: '/var/lib/jenkins/workspace/trs/invent.txt', playbook: '/var/lib/jenkins/workspace/trs/installdocker.yaml'
                ansiblePlaybook credentialsId: 'radikey', disableHostKeyChecking: true, extras: "-e artifactory_credential=${artifactory_credential} -e TAG=${TAG} -e BUILD_NUMBER=${BUILD_NUMBER}", installation: 'ansible', inventory: '/var/lib/jenkins/workspace/trs/invent.txt', playbook: '/var/lib/jenkins/workspace/trs/deployApp.yaml'
            }
            post{
                failure{
                    slackSend( channel: "#random", color: "good", message: "Docker Deployment stage failure")
                }
        }
        }

        stage('Slack Notification of Success') {
            steps {
                slackSend channel: '#random',
                          color: '#8B0000', 
                          message: 'CICD, Pipeline succeded'
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