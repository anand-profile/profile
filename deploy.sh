repo_name="$1"
dockerImage="$2"
dockerimagerepo="$3"

echo "Remove the Docker Container"
echo "###########################"
sudo docker rm $repo_name

sudo docker rm -f `docker ps -a | grep $repo_name | awk {'print $1'}`

echo "Remove Docker Image
echo "###########################"
sudo docker rmi -f `docker images | grep $dockerimagerepo | awk {'print $3'}`


echo "Creating docker container"
echo "###########################"
sudo docker create --name $repo_name -p 80:80 $dockerImage

echo "Starting the docker container"
echo "###########################"
sudo docker start $repo_name