pipeline {
    agent any

    environment {
        DOCKER_IMAGE = 'danielmagdy/nodeapp'  // Define the image name
        DOCKER_TAG = "${GIT_COMMIT}"  // Use the Git commit hash as the tag
        DOCKER_CREDENTIALS = '6424c895-c035-40b8-9bdf-2cd14adc9c3b'  // Jenkins credentials ID for Docker Hub
    }

    stages {
        stage('Checkout Code') {
            steps {
                // Checkout the code directly from GitHub
                checkout scm
            }
        }

        stage('Install Dependencies') {
            steps {
                script {
                    // Install Node.js dependencies using npm
                    echo 'Installing dependencies...'
                    sh 'npm install'
                }
            }
        }

        stage('Lint') {
            steps {
                script {
                    // Run a linting tool (e.g., ESLint)
                    echo 'Running linting...'
                    sh 'npm run lint'
                }
            }
        }

        stage('Test') {
            steps {
                script {
                    // Run unit tests using npm
                    echo 'Running tests...'
                    sh 'npm test'
                }
            }
        }

        stage('Build Docker Image') {
            steps {
                script {
                    // Build Docker image using the Dockerfile in your project
                    echo 'Building Docker image...'
                    sh """
                    docker build -t ${DOCKER_IMAGE}:${DOCKER_TAG} .
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {
                script {
                    // Login to Docker Hub
                    echo 'Logging in to Docker Hub...'
                    docker.withCredentials([usernamePassword(credentialsId: DOCKER_CREDENTIALS, usernameVariable: 'DOCKER_USERNAME', passwordVariable: 'DOCKER_PASSWORD')]) {
                        sh """
                        docker login -u ${DOCKER_USERNAME} -p ${DOCKER_PASSWORD}
                        """
                    }

                    // Push the Docker image to Docker Hub
                    echo 'Pushing Docker image to Docker Hub...'
                    sh """
                    docker push ${DOCKER_IMAGE}:${DOCKER_TAG}
                    """
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Deploy the app (for example, to a staging environment)
                    echo 'Deploying the application...'
                    // Example: `sh './deploy.sh'` if you have a deployment script
                    // Add your deployment commands here
                }
            }
        }
    }

    post {
        always {
            echo 'Cleaning up...'
            // Clean up any temporary files, etc.
        }

        success {
            echo 'Pipeline completed successfully!'
            // Send success notifications (e.g., Slack, email, etc.)
        }

        failure {
            echo 'Pipeline failed.'
            // Send failure notifications (e.g., Slack, email, etc.)
        }
    }
}
