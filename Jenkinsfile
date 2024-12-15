pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'danielmagdy/nodejsapp_jenkins'  // Replace with your Docker Hub username and image name
        // DOCKER_TAG = "latest"  // Tag the image with the Git commit hash
        DOCKER_CREDENTIALS = 'dockerhub_cred'  // Replace with the ID of your Docker Hub credentials stored in Jenkins
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout the code from GitHub
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Install Node.js dependencies
                    echo 'Installing dependencies...'
                    sh 'npm install'
                }
            }
        }

        stage('Lint') {
            steps {
                script {
                    // Run linting (optional, use if you have linting set up)
                    echo 'Running linting...'
                    sh 'npm run lint'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run tests (optional, run your unit tests here)
                    echo 'Running tests...'
                    sh 'npm test'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using the Dockerfile in the repository
                    echo 'Building Docker image...'
                    sh """
                    docker build -t ${DOCKER_IMAGE}:latest .
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Login to Docker Hub using Jenkins credentials
                    echo 'Logging in to Docker Hub...'
                    docker.withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh """
                        docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
                        """
                    }

                    // Push the Docker image to Docker Hub
                    echo 'Pushing Docker image to Docker Hub...'
                    sh """
                    docker push ${DOCKER_IMAGE}:latest
                    """
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the app (optional, if you have a deployment script)
                    echo 'Deploying the application...'
                    // Example: `sh './deploy.sh'`
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            // Clean up after the pipeline, e.g., removing temporary files or containers
        }

        success {
            echo 'Pipeline completed successfully!'
        }

        failure {
            echo 'Pipeline failed.'
        }
    }
}
