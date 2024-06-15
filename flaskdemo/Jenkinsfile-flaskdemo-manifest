pipeline {
  agent any
  stages {
    stage('Clean Workspace') {
      steps {
        cleanWs()
      }
    }

    stage('Update Manifest') {
      steps {
        withCredentials([usernamePassword(credentialsId: 'github2', passwordVariable: 'GIT_PASSWORD', usernameVariable: 'GIT_USERNAME')]) {
          sh "git clone https://github.com/kimhan9/kubernetesmanifest.git"
          sh "cd kubernetesmanifest"
          dir('kubernetesmanifest') {
            sh "sed -i 's+conandor/flaskdemo.*+conandor/flaskdemo:${env.BUILD_NUMBER}+g' deployment.yaml"
            sh "git config user.email conandor@gmail.com"
            sh "git config user.name devops-bot"
            sh "git add ."
            sh "git commit -m 'Done by Jenkins Job changemanifest: ${env.BUILD_NUMBER}'"
            sh "git push https://${GIT_USERNAME}:${GIT_PASSWORD}@github.com/${GIT_USERNAME}/kubernetesmanifest.git HEAD:main"
          }
        }
      }
    }
  }
}