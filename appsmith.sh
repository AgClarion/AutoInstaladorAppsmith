#######################################################

cd
clear
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m _______                   ___  _                                         _        \e[0m"
echo -e "\e[32m(_______)                 / __)(_)                                       | |       \e[0m"
echo -e "\e[32m _         ___   ____   _| |__  _   ____  _   _   ____  _____  ____    __| |  ___  \e[0m"
echo -e "\e[32m| |       / _ \ |  _ \ (_   __)| | / _  || | | | / ___)(____ ||  _ \  / _  | / _ \ \e[0m"
echo -e "\e[32m| |_____ | |_| || | | |  | |   | |( (_| || |_| || |    / ___ || | | |( (_| || |_| |\e[0m"
echo -e "\e[32m \______) \___/ |_| |_|  |_|   |_| \___ ||____/ |_|    \_____||_| |_| \____| \___/ \e[0m"
echo -e "\e[32m                                  (_____|                                          \e[0m"
echo -e "\e[32m          _______                 ______         _         _     \e[0m"
echo -e "\e[32m         (_______)               / _____)       (_)   _   | |    \e[0m"
echo -e "\e[32m  ___     _______  ____   ____  ( (____   ____   _  _| |_ | |__  \e[0m"
echo -e "\e[32m / _ \   |  ___  ||  _ \ |  _ \  \____ \ |    \ | |(_   _)|  _ \ \e[0m"
echo -e "\e[32m| |_| |  | |   | || |_| || |_| | _____) )| | | || |  | |_ | | | |\e[0m"
echo -e "\e[32m \___/   |_|   |_||  __/ |  __/ (______/ |_|_|_||_|   \__)|_| |_|\e[0m"
echo -e "\e[32m                  |_|    |_|                                     \e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"

#######################################################

echo "Preencha as informações a instalar o AppSmith"
echo ""
read -p "Digite seu dominio para acessar o appsmith (ex: painel.dominio.com): " linkappsmith
echo ""
read -p "Digite a porta para o appsmith (padrão: 8181): " portaappsmith
echo ""
read -p "Digite um email para o proxy reverso (ex: contato@dominio.com): " emailappsmith
echo ""

###########################

cd

clear

sudo apt update -y
sudo apt upgrade -y

apt install docker-compose -y
sudo apt update

sudo apt install nginx -y
sudo apt update

sudo apt install certbot -y
sudo apt install python3-certbot-nginx -y
sudo apt update

###########################

cd

mkdir appsmith

cd appsmith

curl -L https://bit.ly/docker-compose-CE -o $PWD/docker-compose.yml

sed -i "s/80:80/$portaappsmith:80/g" docker-compose.yml

sed -i 's/443:443/8443:443/g' docker-compose.yml

docker-compose up -d

###########################

cd

cat > appsmith_nginx << EOL
server {

  server_name $linkappsmith;

  location / {

    proxy_pass http://127.0.0.1:$portaappsmith;

    proxy_http_version 1.1;

    proxy_set_header Upgrade \$http_upgrade;

    proxy_set_header Connection 'upgrade';

    proxy_set_header Host \$host;

    proxy_set_header X-Real-IP \$remote_addr;

    proxy_set_header X-Forwarded-Proto \$scheme;

    proxy_set_header X-Forwarded-For \$proxy_add_x_forwarded_for;
    
    proxy_cache_bypass \$http_upgrade;

	  }

  }
EOL

###############################################

sudo mv appsmith_nginx /etc/nginx/sites-available/

sudo ln -s /etc/nginx/sites-available/appsmith_nginx /etc/nginx/sites-enabled

systemctl reload nginx

sudo certbot --nginx --email $emailappsmith --redirect --agree-tos -d $linkappsmith

###############################################

echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m _                             _              _        \e[0m"
echo -e "\e[32m| |                _          | |            | |       \e[0m"
echo -e "\e[32m| | ____    ___  _| |_  _____ | |  _____   __| |  ___  \e[0m"
echo -e "\e[32m| ||  _ \  /___)(_   _)(____ || | (____ | / _  | / _ \ \e[0m"
echo -e "\e[32m| || | | ||___ |  | |_ / ___ || | / ___ |( (_| || |_| |\e[0m"
echo -e "\e[32m|_||_| |_|(___/    \__)\_____| \_)\_____| \____| \___/ \e[0m"
echo -e "\e[32m                                                       \e[0m"              
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32mAcesse o appsmith através do link: https://$linkappsmith\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32mInscreva-se no meu Canal: https://youtube.com/oriondesign_oficial\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32mSugestões ou duvidas: https://wa.me/+5511973052593\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
echo -e "\e[32m\e[0m"
