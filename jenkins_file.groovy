pipeline {
    agent any 
    environment {
        AWS_REGION = "us-east-1"
        ECR_REPO = "ecr-repo-name" // update with correct ECR repo name
        IMAGE_TAG = "react-app:${env.BUILD_NUMBER}" // image tagging for versioning docker image

    }
    stages {
        stage ('checkout code'){
            steps{
                checkout scm // github or bitbucket
            }
        }

        stage('install dependencies'){
            step{
                sh 'npm install' // install all required packages
            }
        }

        stage('Run Tests'){
            steps{
                sh 'npm test' // runs unit test cases
            }
        }

        stage('Build React App'){
            steps{
                sh 'npm run build' // builds the react application
            }
        }

        stage('Docker Build'){
            steps{
                sh 'docker build -t $ECR_REPO:$IMAGE_TAG .' // creates a new docker image and tags the image.
            }
        }

        stage('Push to ECR'){
            steps{
                script{
                    sh "aws ecr get-login-password --region $AWS_REGION | docker login --username AWS --password-stdin $ECR_REPO" // retriving the aws token and giving to docker login 
                    sh "docker tag $ECR_REPO:$IMAGE_TAG $ECR_REPO:$IMAGE_TAG" // tagging current image to new image
                    sh "docker push $ECR_REPO:$IMAGE_TAG" // pushing the new image
                }
            }
        }

        stage('Deploy'){
            steps{
                sh 'docker run -d -p 80:80 -e REACT_APP_ENV=production $ECR_REPO:$IMAGE_TAG' // deploying to production environment using environment variable
            }
        }
    }
}