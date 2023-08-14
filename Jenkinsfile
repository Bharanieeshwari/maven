pipeline {
    agent {
    node {
        label 'Prod-1'
    }
}
    stages {
        stage('Scan') {
            steps {
                withSonarQubeEnv(installationName: 'sonar-test'){
                    sh "chmod +x -R ${env.WORKSPACE}"
                    sh './mvnw clean org.sonarsource.scanner.maven:sonar-maven-plugin:3.9.0.2155:sonar'
                    }
                }
            }
        
        stage('Install if docker is not avaliable') {
            steps {
                sh 'chmod +x ./bash/docker.sh'
                sh './bash/docker.sh'
            }
        }

        stage('Checking the Old Container') {
            steps {
                sh 'chmod +x ./bash/old-container-check.sh'
                sh './bash/old-container-check.sh'
            }
        }

        stage('Build Java-Web-Application') {
            steps {
                sh 'docker build -t dishoneprabu/java-web-app:latest .'
            }
        }
     
        stage('Launching the latest image') {
            steps {
                sh 'docker run -d --name java-web-app -h java-web-app -p 8080:8080 --restart unless-stopped dishoneprabu/java-web-app:latest'
            }
        }
    }

    post {
        always {
            echo 'Build Completed'
        }
    }
}