#!groovy
branch = env.BRANCH_NAME
def dockerImageTag
def build_number
def dockerImage
def baseImage = 'nginx'
def reponame= 'anand_profile'
def dockerimagerepo = 'anandtest/anand_profile'
def dockerRegistry = 'hub.docker.com'
def dockerlist
def ansibleHostsPath="/home/hosts"


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
							sh ' touch anand_test_docker.txt '
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
		stage('Deploy to CSA') {
            steps {
                script {
				    sh """ docker run --rm -v $WORKSPACE:/home ${dockerimagerepo}:${dockerImageTag} sh -c 'ansible-playbook -vvv /home/deploy.yml -i $ansibleHostsPath --extra-vars="repo_name=$reponame dockerImage=${dockerimagerepo}:${dockerImageTag} dockerimagerepo=$dockerimagerepo"' """
                	// sh """docker run -t -d -p 80:80 --name Nginx_Docker_test ${dockerimagerepo}:${dockerImageTag}"""
                }
            }
        }
	}
}
