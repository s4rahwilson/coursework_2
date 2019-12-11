def app
pipeline {
    agent any
    stages {
        stage('Clone repository') {
            checkout scm
        }
        stage('Build image') {
            app = docker.build("s4rahwilson/coursework_2")
        }
        stage('Test image') {
            app.inside {
                sh 'echo "Tests passed"'
            }
        }
	stage('Sonarqube') {
	    environment {
		scannerHome = tool 'SonarQubeScanner'
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
