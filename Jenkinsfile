pipeline {
    agent any
    stages {
        stage('prepare') {
            steps {
                sh 'echo "prepare"'
            }
        }
        stage('build') {
            steps {
                sh 'bash cd.sh'
            }
        }
    }
    post {
        always {
            echo 'This will always run'
        }
        success {
            sh  '''
              version=$(echo ${GIT_COMMIT}|cut -c1-8)
            '''
        }
        failure {
            echo 'This will run only if failed'
        }
        unstable {
            echo 'This will run only if the run was marked as unstable'
        }
        changed {
            echo 'This will run only if the state of the Pipeline has changed'
            echo 'For example, if the Pipeline was previously failing but is now successful'
        }
    }
}
