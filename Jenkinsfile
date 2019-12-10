pipeline {
    agent any

    stages {
        stage('Clone repository') {
		script {
            		checkout scm
		}
        }

        stage('Build image') {
            app = docker.build("s4rahwilson/coursework_2")
        }

        stage('Sonarqube') {
		environment {
			scannerHome = tool 'SonarQube'
		}
		steps {
			withSonarQubeEnv('sonarqube') {
				sh "${scannerHome}/bin/sonar-scanner"
			}
			timeout(time: 10, unit: 'MINUTES') {
				waitForQualityGate abortPipeline: true
			}
		}
        }

        stage('Push image') {
            docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
                app.push("${env.BUILD_NUMBER}")
                app.push("latest")
            }
        }
    }
}
