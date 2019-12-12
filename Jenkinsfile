node {
    def app
    def remote = [:]
    remote.name = 'vm'
    remote.host = '13.92.156.111'
    remote.user = 'azureuser'
    remote.password = 'password345'
    remote.allowAnyHosts = true

    stage('Clone repository') {
        checkout scm
    }

    stage('Build image') {
        app = docker.build("s4rahwilson/coursework-2")
    }

    stage('SonarQube analysis') {
    def scannerHome = tool 'SonarQube';
    withSonarQubeEnv('SonarQube') {
      sh "${scannerHome}/bin/sonar-scanner"
    }
  }

    stage('Push image') {
        docker.withRegistry('https://registry.hub.docker.com', 'docker-hub-credentials') {
            app.push("${env.BUILD_NUMBER}")
            app.push("latest")
        }
    }

    stage('Remote SSH') {
     sshCommand remote: remote, command: "ls"
   }
}
