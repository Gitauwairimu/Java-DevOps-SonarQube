pipeline {
    agent any
    stages {
        stage('Checkout Codebase') {
            steps{
                checkout scm: [$class: 'GitSCM',userRemoteConfigs: [[credentialsId: 'github-ssh-key',url: 'git@github.com:Gitauwairimu/Java-DevOps-SonarQube.git']]]
            }
        }
        stage('Build Application')
    }
}