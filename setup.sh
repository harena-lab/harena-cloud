sudo apt install -y htop vim curl wget docker-compose

#sudo apt install -y apache2 php 
#sudo a2enmod proxy_http
#sudo a2enmod proxy
#sudo a2enmod proxy_http
#sudo a2enmod proxy_balancer
#sudo a2enmod lbmethod_byrequests

#sudo rm /var/www/html/index.html 
#sudo cp ./configs/apache2/000-default.conf /etc/apache2/sites-available/000-default.conf
#sudo cp ./configs/apache2/index.html /var/www/index.html 
#sudo apache2ctl configtest
#sudo systemctl restart apache2
##sudo apt install -y certbot python-certbot-apache 

#sudo snap install core; sudo snap refresh core
#sudo snap install --classic certbot
#sudo ln -s /snap/bin/certbot /usr/bin/certbot
#sudo certbot --apache
#sudo certbot --apache -d harena.ds4h.org
#sudo certbot renew --dry-run


sudo docker-compose pull
sudo docker-compose up -d


root_folder=$(pwd)

harena_override_docker_compose() 
{
	echo "------------------------------------Overriding $1-----------------------------------"
	sudo docker-compose -f harena/modules/$1/docker-compose.yml -f docker-compose/override/modules/$1/docker-compose.yaml --project-name "harena" up -d 
}


sudo rm harena -r
git clone https://github.com/harena-lab/harena
cd harena
sudo sh ./run.sh
cd ..

echo "------------------------------------ Starting Overriding Process-----------------------------------"


harena_override_docker_compose "harena-space"
harena_override_docker_compose "harena-manager"
harena_override_docker_compose "harena-logger"

sleep 10

sudo systemctl restart apache2
sudo docker ps -a
