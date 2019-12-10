node {
    def app

    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
        app = docker.build("s4rahwilson/coursework_2")
    }
 
    stage('SonarQube analysis') {
              steps {
                   withSonarQubeEnv('SonarQube') {
                        sh 'mvn clean package sonar:sonar'
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
