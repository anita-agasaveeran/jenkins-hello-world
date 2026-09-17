pipeline {
    agent {
        label '!windows'
    }

    options {
        skipStagesAfterUnstable()
    }

    environment {
        DISABLE_AUTH = 'true'
        DB_ENGINE    = 'sqlite'
    }

    stages {
        stage('Build') {
            steps {
                echo "Database engine is ${DB_ENGINE}"
                echo "DISABLE_AUTH is ${DISABLE_AUTH}"
                sh 'printenv'
                sh 'echo "Hello World"'
                sh '''
                    echo "Multiline shell steps works too"
                    ls -lah
                '''
                sh '''
                    mkdir -p build/libs
                    echo "placeholder build artifact" > build/libs/app.jar
                '''
            }
        }
        stage('Deploy') {
            steps {
                timeout(time: 90, unit: 'SECONDS') {
                    retry(5) {
                        sh './flakey-deploy.sh'
                    }
                }
            }
        }
        stage('Test') {
            agent {
                docker { image 'node:24.21.0-alpine3.24' }
            }
            steps {
                sh 'node --eval "console.log(process.arch,process.platform)"'
            }
        }
        stage('Unit Tests') {
            steps {
                sh './run-tests.sh'
            }
        }
    }
    post {
        always {
            echo 'This will always run'
            archiveArtifacts artifacts: 'build/libs/**/*.jar', fingerprint: true
            junit 'build/reports/**/*.xml'
            deleteDir() /* clean up our workspace */
        }
        success {
            echo 'This will run only if successful'
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

