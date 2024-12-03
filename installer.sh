Lpython=`wget -qO- https://www.python.org/ftp/python/ | grep -oP 'href="\d+\.\d+\.\d+/' | sed 's/href="//;s/\/$//' |  cut -d . -f 1,2 | sort -V | tail -n 2 | head -n 1`

declare -A tools='(
["curl"]="apt install curl -y -qq"
["jq"]="apt install jq"
["git"]="apt install git -y -qq"
["python3"]="apt install python${Lpython}"
["pip3"]="apt install python3-pip -y -qq"
["pipx"]="sudo apt install pipx -y -qq &> /dev/null"
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
	echo -e "-p/--print\t:\tTo print all tools offered"
}

function list_tool(){
	for tool in "${!tools[@]}"
	do
		echo "$tool"
	done
}

function check(){
	#+++++++++++++++++++++++++++++++++GO+++++++++++++++++++++++++++++++++++++++++++++++++
	if go version &> /dev/null
	then
		echo "go version | cut -d " " -f 3"
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
			echo -e "[-] ${i}\t:\tManually install: \`${tools[$i]}\` OR \`bash installer.sh -i/--install\`${end}\n"
		fi
        else
		if [[ ${i} == "waybackurls" ]];then
                	echo -e  "[+] ${i}\t:\tv0.1.0\n"
            	elif [[ ${i} == "gauplus" ]];then
                	echo -e  "[+] ${i}\t:\t`gauplus -version | awk '{print $NF}'`\n"
            	elif [[ ${i} == "gospider" ]];then
                	echo -e  "[+] ${i}\t:\t`gospider --version|head -1|awk '{print $NF}'`\n"
            	elif [[ ${i} == "gau" ]];then
                	echo -e "[+] ${i}\t\t:\t`gau --version|awk '{print $NF}'`\n"
            	elif [[ ${i} == "anew" ]];then
                	echo -e  "[+] ${i}\t:\tv0.1.1\n"
            	elif [[ ${i} == "httpx" ]];then
                	echo -e "[+] ${i}\t:\t`httpx -version 2>&1|grep "Current Version"| awk '{print $NF}'`\n"
            	elif [[ ${i} == "katana" ]];then
                	echo -e  "[+] ${i}\t:\t`katana --version 2>&1| tail -1 | awk '{print $NF}'`\n"
            	elif [[ ${i} == "curl" ]];then
                	echo -e "[+] ${i}\t:\t`curl --version|head -1|awk '{print $2}'`\n"
           	elif [[ ${i} == "git" ]];then
                	echo -e "[+] ${i}\t\t:\t`git --version|awk '{print $NF}'`\n"
            	elif [[ ${i} == "pip3" ]];then
                	echo -e "[+] ${i}\t:\t`pip3 --version|awk '{print $2}'`\n"
            	elif [[ ${i} == "waymore" ]];then
			echo -e "[+] ${i}\t:\t`curl -kLs "https://raw.githubusercontent.com/xnl-h4ck3r/waymore/main/waymore/__init__.py" | awk -F'"' '{print $2}'`\n"
            	elif [[ ${i} == "hakrawler" ]];then
                	echo -e "[+] ${i}\t:\t2.1$\n"
            	elif [[ ${i} == "cariddi" ]];then
                	echo -e "[+] ${i}\t:\t`cariddi -version 2>&1| egrep -o "v[0-9.]+"`\n"
            	elif [[ ${i} == "crawley" ]];then
                	echo -e "[+] ${i}\t:\t1.7.7\n"
		elif [[ ${i} == "python3" ]];then
                        echo -e "[+] ${i}\t:\t`python3 -V | awk '{print $NF}' `\n"
            	fi
	fi
	done	

}

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
			

			echo ${PLATFORM}
			LATEST_GO_VERSION="$(curl --silent 'https://go.dev/VERSION?m=text' | head -n 1)";
                        LATEST_GO_DOWNLOAD_URL="https://go.dev/dl/${LATEST_GO_VERSION}.${PLATFORM}.tar.gz"

			echo "${LATEST_GO_VERSION}"
			echo "${LATEST_GO_DOWNLOAD_URL}"

			current=`pwd`
			echo $current
				
			echo -e "cd to home ($USER) directory \n"
                        cd $HOME
                        
			echo -e "Downloading ${LATEST_GO_DOWNLOAD_URL}\n\n";
                        curl -kOJ -L --progress-bar $LATEST_GO_DOWNLOAD_URL
                                
			echo -e "Extracting file...\n"
                        tar -xf ${HOME}/${LATEST_GO_VERSION}.linux-amd64.tar.gz -C ${HOME}

			export GOROOT="$HOME/go" 2>&1 > /dev/null
                        export GOPATH="$HOME/go/packages" 2>&1 > /dev/null
                        export PATH=$PATH:$GOROOT/bin:$GOPATH/bin 2>&1 > /dev/null
                        echo -e "APPENDING THIS LINE BELOW TO YOUR ~/.bashrc OR ~/.zshrc: \n
					export GOROOT=\"$HOME/go\"\n
					export GOPATH=\"$HOME/go/packages\"\n
					export PATH=$PATH:$GOROOT/bin:$GOPATH/bin\n\n"

			cd ${current}
	 fi


	for i in ${!tools[@]};do
		${i} --help &> /dev/null
		if [[ ! $? -eq 0 ]];then
			echo "${tools[${i}]}"
			${tools[${i}]}
			if [[ $? -eq 0 ]];then
				echo "Installing tool...: ${tools[${i}]}"
				printf "[+] ${i} Installed\n"
			fi


		fi
    	done
}

function opt(){
	case $1 in
		'-p'|'--print')
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
