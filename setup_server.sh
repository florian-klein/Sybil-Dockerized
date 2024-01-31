################################################
# This script is used to setup the server config
################################################
COLOR_GREEN='\033[0;32m'
CHECK_MARK='\xE2\x9C\x94'
COLOR_RED='\033[0;31m'
COLOR_BLUE='\033[0;34m'
COLOR_LIGHT_BLUE='\033[0;36m'
COLOR_PURPLE='\033[0;35m'
COLOR_NC='\033[0m' # No Color 
PORT_ICON='📡'
ARROW_ICON=''
SYBIL_LOGO="
  ______  ____  ____  ______   _____  _____     
.' ____ \|_  _||_  _||_   _ \ |_   _||_   _|    
| (___ \_| \ \  / /    | |_) |  | |    | |      
 _.____\`.   \ \/ /     |  __'.  | |    | |   _  
| \____) |  _|  |_    _| |__) |_| |_  _| |__/ | 
 \______.' |______|  |_______/|_____||________|
"

echo -e "${SYBIL_LOGO}"
echo -e "This script will now ask you for some required ${COLOR_PURPLE}configurations${COLOR_NC}. You can always change them later by running the script again."
echo -e "${COLOR_LIGHT_BLUE}Press any key to continue...${COLOR_NC}\n"
read -n 1 -s
echo -e "Configuring server..."
echo -e "---------------------------------------------"

echo -e "${COLOR_LIGHT_BLUE} ${PORT_ICON} \t Please enter the port you want to use for the server internally (localhost) (default: 3000): ${COLOR_NC}\c "
read -r PORT 
if [ -z "$PORT" ]
then
  PORT=3000
fi
echo -e "${COLOR_GREEN} ${CHECK_MARK} \t Port set to ${PORT}${COLOR_NC}"


echo -e "${COLOR_LIGHT_BLUE} ${PORT_ICON} \t Please enter the port you want to expose for the ssh connection(default: 8080): ${COLOR_NC}\c "
read -r SSH_PORT 
if [ -z "$SSH_PORT" ]
then
  SSH_PORT=8080
fi
echo -e "${COLOR_GREEN} ${CHECK_MARK} \t SSH_Port set to ${PORT}${COLOR_NC}"
HOST_NAME=$(hostname)
echo -e "${COLOR_LIGHT_BLUE} [INFO] \t Your hostname is ${HOST_NAME}${COLOR_NC}"
echo -e "${COLOR_RED} This is still todo... Aborting. The script has not changed anything yet. ${COLOR_NC}"





