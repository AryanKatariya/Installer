#!/bin/bash

green="\e[32m"
red="\e[31m"
yellow="\e[33m"
end="\e[0m"
lightred='\e[91m'

portscan_tools=("zmap" "netcat" "masscan" "rustscan" "nmap")
subdomain_tools=("subfinder" "assetfinder" "amass" "findomain")
vulnscan_tools=("nuclei" "nikto" "whatweb")
fuzzing_tools=("ffuf" "dirsearch" "feroxbuster")
secrets_tools=("trufflehog" "gittyleaks" "shhgit")
jsrecon_tools=("linkfinder" "jsfinder" "xnLinkFinder")
wordlist_tools=("seclists" "rockyou")
parsing_tools=("jq" "qsreplace" "anew")
misc_tools=("httpx" "waybackurls" "gau")

declare -A tools=(
    ["zmap"]="sudo apt install zmap -y"
    ["netcat"]="sudo apt install netcat -y"
    ["masscan"]="sudo apt install masscan -y"
    ["rustscan"]="cargo install rustscan"
    ["nmap"]="sudo apt install nmap -y"
    ["subfinder"]="go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest"
    ["assetfinder"]="go install github.com/tomnomnom/assetfinder@latest"
    ["amass"]="sudo snap install amass"
    ["findomain"]="cargo install findomain"
    ["nuclei"]="go install -v github.com/projectdiscovery/nuclei/v3/cmd/nuclei@latest"
    ["nikto"]="sudo apt install nikto -y"
    ["whatweb"]="sudo apt install whatweb -y"
    ["ffuf"]="go install github.com/ffuf/ffuf@latest"
    ["dirsearch"]="git clone https://github.com/maurosoria/dirsearch.git"
    ["feroxbuster"]="cargo install feroxbuster"
    ["trufflehog"]="pip install trufflehog"
    ["gittyleaks"]="gem install gittyleaks"
    ["shhgit"]="git clone https://github.com/eth0izzle/shhgit.git"
    ["linkfinder"]="git clone https://github.com/GerbenJavado/LinkFinder.git"
    ["jsfinder"]="git clone https://github.com/003random/JsFinder.git"
    ["xnLinkFinder"]="git clone https://github.com/xnl-h4ck3r/xnLinkFinder.git"
    ["seclists"]="sudo apt install seclists -y"
    ["rockyou"]="sudo apt install wordlists -y"
    ["jq"]="sudo apt install jq -y"
    ["qsreplace"]="go install github.com/tomnomnom/qsreplace@latest"
    ["anew"]="go install github.com/tomnomnom/anew@latest"
    ["httpx"]="go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest"
    ["waybackurls"]="go install github.com/tomnomnom/waybackurls@latest"
    ["gau"]="go install github.com/lc/gau/v2/cmd/gau@latest"
)

check() {
    local tool_list=("$@")
    echo -e "${yellow}Checking installed tools...${end}"
    for tool in "${tool_list[@]}"; do
        if command -v "$tool" &>/dev/null; then
            echo -e "${green}[✔] $tool is installed${end}"
        else
            echo -e "${red}[✘] $tool is missing${end}"
        fi
    done
}

install() {
    local tool_list=("$@")
    echo -e "${yellow}Installing missing tools...${end}"
    for tool in "${tool_list[@]}"; do
        if ! command -v "$tool" &>/dev/null; then
            echo -e "${green}[+] Installing $tool...${end}"
            eval "${tools[$tool]}"
        else
            echo -e "${green}[✔] $tool already installed${end}"
        fi
    done
}

clear

echo -e "${green}1.${end} 🔍 Port Scanning Tool"
echo -e "${green}2.${end} 🌐 Subdomain & DNS Enumeration"
echo -e "${green}3.${end} 🛠️ Vulnerability Scanners"
echo -e "${green}4.${end} 🧨 Content Discovery & Fuzzing"
echo -e "${green}5.${end} 🔑 Secrets & Info Leakage Detection"
echo -e "${green}6.${end} 🧠 JavaScript Recon & URL Extraction"
echo -e "${green}7.${end} 📁 Wordlists & Payloads"
echo -e "${green}8.${end} 🪛 Parsing & Post-Processing Tools"
echo -e "${green}9.${end} 🧰 Misc"
echo -e "${green}10.${end} ⬤ All"

printf "${yellow}Select a item: ${end}"
read category

case $category in
    1) selected=("${portscan_tools[@]}") ;;
    2) selected=("${subdomain_tools[@]}") ;;
    3) selected=("${vulnscan_tools[@]}") ;;
    4) selected=("${fuzzing_tools[@]}") ;;
    5) selected=("${secrets_tools[@]}") ;;
    6) selected=("${jsrecon_tools[@]}") ;;
    7) selected=("${wordlist_tools[@]}") ;;
    8) selected=("${parsing_tools[@]}") ;;
    9) selected=("${misc_tools[@]}") ;;
    10)
        selected=(
            "${portscan_tools[@]}"
            "${subdomain_tools[@]}"
            "${vulnscan_tools[@]}"
            "${fuzzing_tools[@]}"
            "${secrets_tools[@]}"
            "${jsrecon_tools[@]}"
            "${wordlist_tools[@]}"
            "${parsing_tools[@]}"
            "${misc_tools[@]}"
        ) ;;
    *) echo -e "${red}Invalid choice.${end}"; exit 1 ;;
esac

echo -e "\nList of selected tools:"
i=1
for tool in "${selected[@]}"; do
    echo -e "${lightred}$i.      ${yellow}$tool${end}"
    ((i++))
done

echo -e "\n${green}1.${end} Check Installed Tools"
echo -e "${green}2.${end} Install Missing Tools"
printf "${yellow}Action to perform: ${end}"
read action

if [[ "$action" == "1" ]]; then
    check "${selected[@]}"
elif [[ "$action" == "2" ]]; then
    install "${selected[@]}"
else
    echo -e "${red}Invalid action.${end}"
fi
