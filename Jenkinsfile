pipeline {
  agent {
    label "java"
  }

  parameters {
    string(name: 'gitBranch', defaultValue: 'master', description: 'This is the first param')
  }

  // tools {
  //     // Install the Maven version configured as "M3" and add it to the path.
  //     maven "M3"
  // }

  stages {
        stage('Terraform init') {
          steps {
            // Get some code from a GitHub repository
            // checkout scmGit(branches: [
            //     [name: params.gitBranch]
            //   ],
            //   userRemoteConfigs: [
            //     [url: 'https://github.com/ducluanxutrieu/jenkins_devops.git']
            //   ])
            withAWS([credentials: "	private"]) {
              sh 'terraform init'
            }

            // To run Maven on a Windows agent, use
            // bat "mvn -Dmaven.test.failure.ignore=true clean package"
          }
        }
        stage('Terraform plan') {
          steps {
            sh 'terraform plan -out'
          }
        }
  }
}

// Groovy