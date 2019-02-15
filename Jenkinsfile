#!groovy
branch = env.BRANCH_NAME
def dockerImageTag
def build_number
def dockerImage
def baseImage = 'nginx'
def dockerimagerepo = 'anandtest/nginximages'
def dockerRegistry = 'hub.docker.com'
def dockerlist


pipeline {
    agent any
    stages {
        stage('Clean Workspace') {
            steps {
                deleteDir()
                echo 'Cleanup done'
            }
        }  
        stage('Initialization') {
        	steps {
        	    checkout scm
        	    script {
                    echo "Hello anand"
			    	echo "${branch}"
			    	dockerImageTag="$BUILD_NUMBER"
                    build_number="${env.BUILD_ID}"
                    echo "The build number $build_number"
			    	echo "The Job build number are $dockerImageTag"
                }

        	}

        }
        stage('Build an Image') {
            steps {
                echo "Building Docker Image"
                script {
                       docker.image(baseImage).inside { 
							sh ' ls -ltr'
                        }
			dockerImage = docker.build "${dockerimagerepo}:${dockerImageTag}"
                    sh 'docker images'
                    sh 'docker ps -a'
                    echo "$dockerImage"
                    
                }
            }
        }
        stage('Docker Publish to Registry') {
			steps {
				echo "Pushing Docker image to Registory"
				script {
					sh 'docker login --username="anandgit71" --password="anandgit12" ${dockerRegistry}'
					dockerImage.push();
					
				}
			}
		}
		stage('Remove published Docker Image and Container') {
            steps {
                script {
                    sh """docker rm  -f Nginx_Docker_test"""
                	sh 'docker rmi ${docker images}'
                }
            }
        }
		stage('Deploy to CSA') {
            steps {
                script {
                	sh """docker run -t -d -p 80:80 --name Nginx_Docker_test ${dockerimagerepo}:${dockerImageTag}"""
                }
            }
        }
	}
}
