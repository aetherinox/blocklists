#!/bin/bash

# #
#   @for                https://github.com/Aetherinox/csf-firewall
#   @workflow           blocklist-generate.yml
#   @type               bash script
#   @summary            compiles a blocklist which can be used in the BitTorrent client Transmission.
#   
#   @terminal           .github/scripts/bt-transmission.sh
#
#   @command            bt-transmission.sh
# #

APP_VER=("1" "0" "0" "0")                                                                       # current script version
APP_DEBUG=false                                                                                 # debug mode
APP_REPO="Aetherinox/dev-kw"                                                                    # repository
APP_REPO_BRANCH="main"                                                                          # repository branch
APP_THIS_FILE=$(basename "$0")                                                                  # current script file
APP_THIS_DIR="${PWD}"                                                                           # Current script directory
APP_FILE_TEMP="bt_temp"                                                                         # name of temp file to use throughout process
APP_FILE_PERM_DIR="blocklists/transmission"                                                     # folder where perm files will be stored
APP_FILE_PERM="${APP_FILE_PERM_DIR}/blocklist"                                                  # name of file to save at the end of the process
APP_FILE_PERM_EXT="ipset"                                                                       # name of final file extension
APP_ZIP_FILE="wael.list.p2p.zip"                                                                # zip to download from waelisa/Best-blocklist
APP_ZIP_READ_FILE="wael.list.p2p"                                                               # file to target and read inside the zip
APP_ZIP_URL="https://raw.githubusercontent.com/waelisa/Best-blocklist/main/${APP_ZIP_FILE}"     # location to download bt blocklist zip
APP_AGENT="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36"
APP_URL_CBUCKET="https://mirror.codebucket.de/transmission/blocklist.p2p"
APP_URL_IBL="https://www.iblocklist.com/lists.php"

# #
#   vars > colors
#
#   tput setab  [1-7]       – Set a background color using ANSI escape
#   tput setb   [1-7]       – Set a background color
#   tput setaf  [1-7]       – Set a foreground color using ANSI escape
#   tput setf   [1-7]       – Set a foreground color
# #

## Bash Colour output
if tput setaf 0 &>/dev/null; then
    echo -e "Using Colors: TPUT"
    RESET="$(tput sgr0)"
    NORMAL=$(tput sgr0)
    WHITE=$(tput setaf 255)
    BOLD=$(tput bold)
    DIM=$(tput dim)
    UNDERLINE=$(tput smul)
    BLINK=$(tput blink)
    INVERTED=$(tput smso)
    DEFAULT=$(tput setaf 7)
    BLACK=$(tput setaf 0)
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 156)
    BLUE=$(tput setaf 033)
    MAGENTA=$(tput setaf 5)
    CYAN=$(tput setaf 6)
    GREYL=$(tput setaf 250)
    GREYD=$(tput setaf 244)
    GREYDD=$(tput setaf 240)
    ORANGE=$(tput setaf 202)
    ORANGED=$(tput setaf 208)
    YELLOWL=$(tput setaf 190)
    BLUEL=$(tput setaf 33)
    DEV=$(tput setaf 157)
    FUCHSIA=$(tput setaf 198)
    PINK=$(tput setaf 200)
else
    echo -e "Using Colors: ANSI"
    RESET="\e[0m"
    NORMAL="\e[97m"
    WHITE="\e[97m"
    BOLD="\e[1m"
    DIM="\e[2m"
    UNDERLINE="\e[4m"
    BLINK="\e[5m"
    INVERTED="\e[7m"
    HIDDEN="\e[8m"
    DEFAULT="\e[39m"
    BLACK="\e[30m"
    RED="\e[31m"
    GREEN="\e[32m"
    YELLOW="\e[33m"
    BLUE="\e[34m"
    MAGENTA="\e[35m"
    CYAN="\e[36m"
    GREYL="\e[37m"
    GREYD="\e[90m"
    REDL="\e[91m"
    GREENL="\e[92m"
    YELLOWL="\e[93m"
    BLUEL="\e[94m"
    MAGENTAL="\e[95m"
    CYANL="\e[96m"
    YELLOW_BGN="\e[43m"
    BLUE_BGN="\e[44m"
    MAGENTA_BGN="\e[45m"
    GREYD_BGN="\e[100m"
    RED_BGN="\e[40m"
    RED_BGL="\e[101m"
    BLUE_BGL="\e[104m"
    ORANGE="\e[41m"
    ORANGED="\e[41m"
fi

# #
#   Helper > Show Color Chart
# #

function COLORS_BG()
{
    for fgbg in 38 48 ; do # Foreground / Background
        for color in {0..255} ; do # Colors
            # Display the color
            printf "\e[${fgbg};5;%sm  %3s  \e[0m" $color $color
            # Display 6 colors per lines
            if [ $((($color + 1) % 6)) == 4 ] ; then
                echo # New line
            fi
        done
        echo # New line
    done
    
    exit 0
}

# #
#   List of websites to download transmission rules from
# #

domain_list=(
    "https://reputation.alienvault.com/reputation.generic"
    "https://www.binarydefense.com/banlist.txt"
    "https://lists.blocklist.de/lists/all.txt"
    "https://iplists.firehol.org/files/bruteforceblocker.ipset"
    "https://cinsscore.com/list/ci-badguys.txt"
    "https://iplists.firehol.org/files/cruzit_web_attacks.ipset"
    "https://www.darklist.de/raw.php"
    "https://rules.emergingthreats.net/blockrules/compromised-ips.txt"
    "https://feodotracker.abuse.ch/downloads/ipblocklist.txt"
    "https://iplists.firehol.org/files/nixspam.ipset"
    "https://sslbl.abuse.ch/blacklist/sslipblacklist.txt"
    "https://pgl.yoyo.org/adservers/iplist.php?ipformat=plain&showintro=0&mimetype=plaintext"
)

# #
#	Loop each website above and download the rules
# #

echo -e "  🌎  ${WHITE}Downloading files from domain list${RESET}"
for i in ${domain_list[@]}; do
    echo -e "      📄  ${GREYDD}Downloading ${GREEN}${i}${RESET}"
	wget -q "${i}" -O - | sed "/^#.*/d" | grep -oE "\b([0-9]{1,3}\.){3}[0-9]{1,3}\b" | sort --unique >> "${APP_FILE_TEMP}_1.txt"
done

# #
#	combined_1 > Generate BT combined file
# #

echo -e "  📄  ${WHITE}Migrating ${BLUEL}${APP_FILE_TEMP}_1.txt${RESET} => ${BLUEL}${APP_FILE_TEMP}_2.txt${RESET}"
while read line; do 
	echo "blocklist:$line-$line"; 
done < "${APP_FILE_TEMP}_1.txt" > "${APP_FILE_TEMP}_2.txt"

# #
#   combined_1 > Download iblocklist.com rules, filter out nonsense and add to file
# #

echo -e "  🌎  ${WHITE}Downloading ${GREEN}${APP_URL_IBL}${RESET}${GREYL} => ${BLUEL}${APP_FILE_TEMP}_2.txt${RESET}"
curl -sSL -A "${APP_AGENT}" "${APP_URL_IBL}" \
        | sed -n "s/.*value='\(http:.*\)'.*/\1/p" \
        | sed "s/\&amp;/\&/g" \
        | sed "s/http/\"http/g" \
        | sed "s/gz/gz\"/g" \
        | xargs curl -s -L \
        | gunzip \
        | egrep -v '^#' \
        | sed "/^$/d" >> "${APP_FILE_TEMP}_2.txt"
        
# #
#	combined_1 > Codebucket > Blocklist
#
#	Includes:
#		- spamhaus
#		- alienvault_reputation
#		- blocklist_de
#		- bruteforceblocker
#		- ciarmy
#		- cruzit_web_attacks
#		- nixspam
#		- yoyo_adservers
#		- dm_tor
#		- dshield
# #

echo -e "  🌎  ${RESET}Downloading ${GREEN}${APP_URL_CBUCKET}${RESET} => ${BLUEL}${APP_FILE_TEMP}_2.txt${RESET}"
curl -sSL -A "${APP_AGENT}" "${APP_URL_CBUCKET}" >> "${APP_FILE_TEMP}_2.txt"

# #
#	Download zip and extract rules
# #

echo -e "  🗄️   ${RESET}Downloading zip ${GREEN}${APP_ZIP_URL}${RESET}"
curl -sSLO -A "${APP_AGENT}" "${APP_ZIP_URL}"

# #
#	Read target file in zip and filter out the rules, add to temp file
# #

echo -e "  🗜️   ${RESET}Unzipping ${ORANGE}${APP_ZIP_FILE}${RESET} and reading ${ORANGE}${APP_ZIP_READ_FILE}${RESET} => ${BLUEL}${APP_FILE_TEMP}_2.txt${RESET}"
P2P=$(unzip -p "${APP_ZIP_FILE}" "${APP_ZIP_READ_FILE}" | sed "/^#.*/d" | grep -Ev "^[0-9][0-9][0-9]\.[0-9][0-9][0-9].*" >> "${APP_FILE_TEMP}_2.txt")

# #
#   Creating Perm Folder
# #

echo -e "  📁  ${WHITE}Create folder ${BLUEL}${APP_FILE_PERM_DIR}${RESET}"
mkdir -p ${APP_FILE_PERM_DIR}

# #
#	Read temp file, sort data, output to final version
# #

echo -e "  〽️  ${WHITE}Sorting ${BLUEL}${APP_FILE_TEMP}_2.txt${RESET} => ${YELLOW}${APP_FILE_PERM}.${APP_FILE_PERM_EXT}${RESET}"
sort --unique "${APP_FILE_TEMP}_2.txt" > "${APP_FILE_PERM}.${APP_FILE_PERM_EXT}"

# #
#   gzip final version
# #

echo -e "  📦  ${WHITE}Creating ${YELLOW}${APP_FILE_PERM}.gz${RESET}"
gzip -c "${APP_FILE_PERM}.${APP_FILE_PERM_EXT}" > "${APP_FILE_PERM}.gz"

# #
#   Confirm gz file created
# #

if [ -f "${APP_FILE_PERM}.gz" ]; then
    echo -e "  ✔️   ${GREEN}Successfully created package ${YELLOW}${APP_FILE_PERM}.gz${RESET}"
else
    echo -e "  ⭕   ${REDL}Could not create ${YELLOW}${APP_FILE_PERM}.gz -- aborting${RESET}"
    exit 1
fi

# #
#   Cleanup
# #

if [ -f "${APP_FILE_TEMP}_1.txt" ]; then
    echo -e "  🗑️   ${GREYD}Cleanup ${APP_FILE_TEMP}_1.txt${RESET}"
    rm "${APP_FILE_TEMP}_1.txt"
fi

if [ -f "${APP_FILE_TEMP}_2.txt" ]; then
    echo -e "  🗑️   ${GREYD}Cleanup ${APP_FILE_TEMP}_2.txt${RESET}"
    rm "${APP_FILE_TEMP}_2.txt"
fi

if [ -f "${APP_ZIP_FILE}" ]; then
    echo -e "  🗑️   ${GREYD}Cleanup ${APP_ZIP_FILE}${RESET}"
    rm "${APP_ZIP_FILE}"
fi

if [ -f "${APP_ZIP_READ_FILE}" ]; then
    echo -e "  🗑️   ${GREYD}Cleanup ${APP_ZIP_READ_FILE}${RESET}"
    rm "${APP_ZIP_READ_FILE}"
fi