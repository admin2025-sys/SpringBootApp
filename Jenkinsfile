pipeline {
    agent any

    stages {

        stage('Code Clone') {
            steps {
                git url: "https://github.com/admin2025-sys/SpringBootApp.git", branch: "main"
            }
        }
        
        stage("Push To DockerHub") {
            steps {
                withCredentials([
                    usernamePassword(
                        credentialsId: "dockerHubCreds",
                        usernameVariable: "dockerHubUser",
                        passwordVariable: "dockerHubPass"
                    )
                ]) {
                    sh 'echo $dockerHubPass | docker login -u $dockerHubUser --password-stdin'
                    sh "docker image tag bankappdemo:latest $dockerHubUser/bankapp:latest"
                    sh "docker push $dockerHubUser/bankapp:latest"
                }
            }
        }

        stage('Trivy Scan') {
            steps {
                script {
                    // Scan the pushed image for vulnerabilities
                    sh "trivy fs ."
                }
            }
        }

        stage('Deploy') {
            steps {
                sh "docker compose down || true"
                sh "docker compose up -d"
            }
        }
    }
}
