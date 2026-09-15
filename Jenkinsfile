pipeline {
    agent any

    options {
        timestamps()
    }

    stages {
        stage('Create venv') {
            steps {
                bat 'python -m venv venv'
            }
        }

        stage('Install dependencies') {
            steps {
                bat 'venv\\Scripts\\pip install -r requirements.txt'
            }
        }

        stage('Install Browser binaries') {
            steps {
                bat 'venv\\Scripts\\rfbrowser init'
            }
        }

        stage('Run tests') {
            steps {
                bat 'venv\\Scripts\\robot --outputdir results tests\\login_tests.robot'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'results/**', allowEmptyArchive: true
            publishHTML(target: [
                reportDir: 'results',
                reportFiles: 'report.html',
                reportName: 'Robot Framework Report',
                keepAll: true,
                alwaysLinkToLastBuild: true
            ])
        }
    }
}