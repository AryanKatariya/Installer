black='\e[38;5;016m'
#black='\e[30m'
greenbg='\e[48;5;038m'
bluebg='\e[48;5;038m'${black}
red='\e[31m'
redbg='\e[30;41m'${black}
lightred='\e[91m'
blink='\e[5m'
lightblue='\e[38;5;109m'
green='\e[32m'
greenbg='\e[48;5;038m'${black}
yellow='\e[33m'
logo='\033[0;36m'
upper="${lightblue}╔$(printf '%.0s═' $(seq "80"))╗${end}"
lower="${lightblue}╚$(printf '%.0s═' $(seq "80"))╝${end}"
right=$(printf '\u2714')
cross=$(printf '\xE2\x9C\x98')
right=$(printf '\xE2\x9C\x94')
end='\e[0m'

Lpython=`wget -qO- https://www.python.org/ftp/python/ | grep -oP 'href="\d+\.\d+\.\d+/' | sed 's/href="//;s/\/$//' |  cut -d . -f 1,2 | sort -V | tail -n 2 | head -n 1`

declare -A tools='(
["curl"]="sudo apt install curl -y -qq"
["jq"]="sudo apt install jq -y -qq"
["git"]="sudo apt install git -y -qq"
["python3"]="sudo apt install python${Lpython}"
["pip3"]="sudo apt install python3-pip -y -qq"
["hakrawler"]="go install github.com/hakluke/hakrawler@latest"
["cariddi"]="go install github.com/edoardottt/cariddi/cmd/cariddi@latest"
["gospider"]="go install github.com/jaeles-project/gospider@latest"
["crawley"]="go install -v github.com/s0rg/crawley/cmd/crawley@latest"
["waymore"]="sudo pip3 install git+https://github.com/xnl-h4ck3r/waymore.git --break-system-packages -v"
["katana"]="go install github.com/projectdiscovery/katana/cmd/katana@latest"
["waybackurls"]="go install github.com/tomnomnom/waybackurls@latest"
["gauplus"]="go install github.com/bp0lr/gauplus@latest"
["gau"]="go install github.com/lc/gau/v2/cmd/gau@latest"
["httpx"]="go install github.com/projectdiscovery/httpx/cmd/httpx@latest"
["anew"]="go install github.com/tomnomnom/anew@master"
#++++++++++++++++++++++ FUZZING ++++++++++++++++++++++++++++++++++++++++
["gobuster"]="go install github.com/OJ/gobuster/v3@latest"
["ffuf"]="go install github.com/ffuf/ffuf/v2@latest"
["subfinder"]="go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
)'

function help(){
	echo -e "-l/--list\t:\tTo list all tools offered"
}

function list_tool(){
	i=1
	for tool in "${!tools[@]}"
	do
		echo -e "${lightred}${i}.\t${yellow}$tool${end}"
		((i++))
	done
}

function check(){
	#+++++++++++++++++++++++++++++++++GO+++++++++++++++++++++++++++++++++++++++++++++++++
	if go version &> /dev/null
	then
		echo -e "\n${green}[${right} ] go${end}\t\t:\t`go version | awk -F" " '{print $3}'`\n"
	else
		echo "Install go manually OR run \"bash installer.sh -i\""
	fi
	
	#++++++++++++++++++++++++++++++++Others+++++++++++++++++++++++++++++++++++++++++++++++
	
	for i in "${!tools[@]}";do

        ${i} --help &> /dev/null
        if [[ ! $? -eq 0 ]];then
		if [[ ${i} == "gau" ]];then
			echo -e "[-] ${i}\t\t:\tManually install: \`${tools[$i]}\` OR \`bash installer.sh -i/--install\`${end}\n"
		else
			echo -e "${red}[${cross} ] ${i}${end}\t:\t${redbg}Manually install: \`${tools[$i]}\` OR \`bash installer.sh -i/--install\`${end}\n"
		fi
        else
		if [[ ${i} == "waybackurls" ]];then
                	echo -e "${green}[${right} ] ${i}${end}:\tv0.1.0\n"
            	elif [[ ${i} == "gauplus" ]];then
                	echo -e "${green}[${right} ] ${i}${end}\t:\t`gauplus -version | awk '{print $NF}'`\n"
            	elif [[ ${i} == "gospider" ]];then
                	echo -e "${green}[${right} ] ${i}${end}\t:\t`gospider --version|head -1|awk '{print $NF}'`\n"
            	elif [[ ${i} == "gau" ]];then
                	echo -e "${green}[${right} ] ${i}${end}\t:\t`gau --version|awk '{print $NF}'`\n"
            	elif [[ ${i} == "anew" ]];then
                	echo -e "${green}[${right} ] ${i}${end}\t:\tv0.1.1\n"
            	elif [[ ${i} == "httpx" ]];then
                	echo -e "${green}[${right} ] ${i}${end}\t:\t`httpx -version 2>&1|grep "Current Version"| awk '{print $NF}'`\n"
            	elif [[ ${i} == "katana" ]];then
                	echo -e "${green}[${right} ] ${i}${end}\t:\t`katana --version 2>&1| tail -1 | awk '{print $NF}'`\n"
            	elif [[ ${i} == "curl" ]];then
                	echo -e "${green}[${right} ] ${i}${end}\t:\t`curl --version|head -1|awk '{print $2}'`\n"
           	elif [[ ${i} == "git" ]];then
                	echo -e "${green}[${right} ] ${i}${end}\t:\t`git --version|awk '{print $NF}'`\n"
            	elif [[ ${i} == "pip3" ]];then
                	echo -e "${green}[${right} ] ${i}${end}\t:\t`pip3 --version|awk '{print $2}'`\n"
            	elif [[ ${i} == "waymore" ]];then
			echo -e "${green}[${right} ] ${i}${end}\t:\t`curl -kLs "https://raw.githubusercontent.com/xnl-h4ck3r/waymore/main/waymore/__init__.py" | awk -F'"' '{print $2}'`\n"
            	elif [[ ${i} == "hakrawler" ]];then
                	echo -e "${green}[${right} ] ${i}${end}\t:\t2.1\n"
            	elif [[ ${i} == "cariddi" ]];then
                	echo -e "${green}[${right} ] ${i}${end}\t:\t`cariddi -version 2>&1| egrep -o "v[0-9.]+"`\n"
            	elif [[ ${i} == "crawley" ]];then
                	echo -e "${green}[${right} ] ${i}${end}\t:\t1.7.7\n"
		elif [[ ${i} == "python3" ]];then
                        echo -e "${green}[${right} ] ${i}${end}\t:\t`python3 -V | awk '{print $NF}' `\n"
		elif [[ ${i} == "subfinder" ]];then
                        echo -e "${green}[${right} ] ${i}${end}\t:\t`subfinder -version 2>&1 | head -n 1 | cut -d " " -f 4`\n"
		elif [[ ${i} == "ffuf" ]];then
                        echo -e "${green}[${right} ] ${i}${end}\t:\t`ffuf -V | awk '{print $NF}' | cut -d "-" -f 1`\n"
		elif [[ ${i} == "jq" ]];then
                        echo -e "${green}[${right} ] ${i}${end}\t\t:\t`jq -V | cut -d "-" -f 2`\n"
		elif [[ ${i} == "gobuster" ]];then
                        echo -e "${green}[${right} ] ${i}${end}\t:\t`gobuster version`\n"
            	fi
	fi
	done	

}

#function progress_bar() {
#    local duration=$1
#    local interval=0.1
#    local steps=$(echo "$duration/$interval" | bc)
#    local bar=""
#    for ((i = 0; i < steps; i++)); do
#        bar="${bar}#"
#        printf "\r[%-50s] %d%%" "$bar" $((2 * i))
#        sleep $interval
#    done
#    echo ""
#}


function install(){

	 if ! go version &> /dev/null;then
                                OS="$(uname -s)"
                                ARCH="$(uname -m)"
                                case $OS in
                                    "Linux")
                                        case $ARCH in
                                                "x86_64")
                                                        ARCH=amd64
                                                        ;;
                                                "aarch64")
                                                        ARCH=arm64
                                                        ;;
                                                "armv6" | "armv7l")
                                                        ARCH=armv6l
                                                        ;;
                                                "armv8")
                                                        ARCH=arm64
                                                        ;;
                                                "i686")
                                                        ARCH=386
                                                        ;;
                                                .*386.*)
                                                        ARCH=386
                                                        ;;
                                        esac
                        PLATFORM="linux-$ARCH"
                        ;;
                                        "Darwin")
                                                case $ARCH in
                                                        "x86_64")
                                                                ARCH=amd64
                                                                ;;
                                                        "arm64")
                                                                ARCH=arm64
                                                                ;;
                                                esac
                        PLATFORM="darwin-$ARCH"
                        ;;
                                esac
			

			#echo ${PLATFORM}
			LATEST_GO_VERSION="$(curl --silent 'https://go.dev/VERSION?m=text' | head -n 1)";
                        LATEST_GO_DOWNLOAD_URL="https://go.dev/dl/${LATEST_GO_VERSION}.${PLATFORM}.tar.gz"

			current=`pwd`
			
			echo -e "${green}Installing go version:${LATEST_GO_VERSION}${end}"	
			echo -e "cd to home ($USER) directory \n"
                        cd $HOME
                        
			echo -e "Downloading ${LATEST_GO_DOWNLOAD_URL}\n\n";
                        curl -kOJ -L --progress-bar $LATEST_GO_DOWNLOAD_URL
                                
			echo -e "Extracting file...\n"
                        tar -xf ${HOME}/${LATEST_GO_VERSION}.linux-amd64.tar.gz -C ${HOME}

			#echo 'export GOROOT="\$HOME/go"' >> .bashrc
                        #echo 'export GOPATH="\$HOME/go/packages"' >> .bashrc
                        #echo 'export PATH=\$PATH:\$GOROOT/bin:\$GOPATH/bin' >> .bashrc

			export GOROOT="$HOME/go"
			export GOPATH="$HOME/go/packages"
			export PATH="$PATH:$GOROOT/bin:$GOPATH/bin"


			#echo -e "APPENDING THIS LINES TO YOUR ~/.bashrc OR ~/.zshrc: \n
					#export GOROOT=\"$HOME/go\"\n
					#export GOPATH=\"$HOME/go/packages\"\n
					#export PATH=$PATH:$GOROOT/bin:$GOPATH/bin\n\n"
			
			`source ~/.bashrc`
		        #exec bash	

			#cd ${current}
		else
			echo -e "${green}[${right} ]${end} go is Already Installed\n"
	 fi


	for i in ${!tools[@]};do
		${i} --help &> /dev/null
		if [[ ! $? -eq 0 ]];then
			echo -e "\nInstalling $i..."
			echo "Running: ${tools[${i}]}"
			${tools[${i}]}
			if [[ $? -eq 0 ]];then
				echo "Installing tool...: ${tools[${i}]}"
				echo -e "${green}[${right} ]${end} ${i} Installed\n"
			fi
		else
			echo -e "${green}[${right} ]${end} ${i} is Already Installed\n"
		fi
    	done
}

function opt(){
	case $1 in
		'-l'|'--print')
			list_tool
			;;
		'-c'|'--check')
			check
			;;
		'-i'|'--install')
			install
			;;
		'-h' | '--help')
			help
			;;
	esac

}

opt $@
