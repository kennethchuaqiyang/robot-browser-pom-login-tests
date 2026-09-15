pipeline {
    agent {
        docker {
            image 'mcr.microsoft.com/playwright:v1.62.1-jammy'
            args '-u root'
        }
    }

    options {
        timestamps()
    }

    stages {
        stage('Install Python dependencies') {
            steps {
                sh 'apt-get update && apt-get install -y python3-pip'
                sh 'pip3 install -r requirements.txt'            }
        }

        stage('Init Browser library') {
            steps {
                // Browsers already present in this image at the matching version,
                // so skip re-downloading them — just set up the JS-side wrapper.
                sh 'rfbrowser init --skip-browsers'
            }
        }

        stage('Run tests') {
            steps {
                sh 'robot --outputdir results tests/login_tests.robot'
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