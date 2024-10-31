#!/bin/bash

# #
#   @for                https://github.com/Aetherinox/csf-firewall
#   @workflow           blocklist-generate.yml
#   @type               bash script
#   @summary            generate ipset by fetching locally specified file in /blocks/ repo folder
#                       copies local ipsets from .github/blocks/${ARG_BLOCKS_CAT}/*.ipset
#   
#   @terminal           .github/scripts/bl-block.sh \
#                           blocklists/02_privacy_general.ipset \
#                           privacy
#
#   @workflow           # Privacy › General
#                       chmod +x ".github/scripts/bl-block.sh"
#                       run_general=".github/scripts/bl-block.sh 02_privacy_general.ipset privacy"
#                       eval "./$run_general"
#
#   @command            bl-block.sh <ARG_SAVEFILE> <ARG_BLOCKS_CAT>
#                       bl-block.sh 02_privacy_general.ipset privacy
#
#                       📁 .github
#                           📁 blocks
#                               📁 privacy
#                                   📄 *.txt
#                           📁 scripts
#                               📄 bl-block.sh
#                           📁 workflows
#                               📄 blocklist-generate.yml
#
# #

# #
#   Arguments
#
#   This bash script has the following arguments:
#
#       ARG_SAVEFILE        (str)       file to save IP addresses into
#       ARG_BLOCKS_CAT      (str)       which blocks folder to inject static IP addresses from
# #

APP_FILE=$(basename "$0")
ARG_SAVEFILE=$1
ARG_BLOCKS_CAT=$2

# #
#   Validation checks
# #

if [[ -z "${ARG_SAVEFILE}" ]]; then
    echo -e "  ⭕ No output file specified for saving by script ${APP_FILE}"
    echo -e
    exit 1
fi

if [[ -z "${ARG_BLOCKS_CAT}" ]]; then
    echo -e "  ⭕  Aborting -- no static file category specified. ex: privacy"
    exit 1
fi

# #
#    Define > General
# #

SECONDS=0                                               # set seconds count for beginning of script
APP_DIR=${PWD}                                          # returns the folder this script is being executed in
APP_REPO="Aetherinox/dev-kw"                            # repository
APP_REPO_BRANCH="main"                                  # repository branch
APP_OUT=""                                              # each ip fetched from stdin will be stored in this var
APP_FILE_PERM="${ARG_SAVEFILE}"                         # perm file when building ipset list
COUNT_LINES=0                                           # number of lines in doc
COUNT_TOTAL_SUBNET=0                                    # number of IPs in all subnets combined
COUNT_TOTAL_IP=0                                        # number of single IPs (counts each line)
BLOCKS_COUNT_TOTAL_IP=0                                 # number of ips for one particular file
BLOCKS_COUNT_TOTAL_SUBNET=0                             # number of subnets for one particular file
TEMPL_NOW=`date -u`                                     # get current date in utc format
TEMPL_ID=$(basename -- ${APP_FILE_PERM})                # ipset id, get base filename
TEMPL_ID="${TEMPL_ID//[^[:alnum:]]/_}"                  # ipset id, only allow alphanum and underscore, /description/* and /category/* files must match this value
TEMPL_UUID=$(uuidgen -m -N "${TEMPL_ID}" -n @url)       # uuid associated to each release
APP_AGENT="Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36"
TEMPL_DESC=$(curl -sSL -A "${APP_AGENT}" "https://raw.githubusercontent.com/${APP_REPO}/${APP_REPO_BRANCH}/.github/descriptions/${TEMPL_ID}.txt")
TEMPL_CAT=$(curl -sSL -A "${APP_AGENT}" "https://raw.githubusercontent.com/${APP_REPO}/${APP_REPO_BRANCH}/.github/categories/${TEMPL_ID}.txt")
TEMPL_EXP=$(curl -sSL -A "${APP_AGENT}" "https://raw.githubusercontent.com/${APP_REPO}/${APP_REPO_BRANCH}/.github/expires/${TEMPL_ID}.txt")
TEMP_URL_SRC=$(curl -sSL -A "${APP_AGENT}" "https://raw.githubusercontent.com/${APP_REPO}/${APP_REPO_BRANCH}/.github/url-source/${TEMPL_ID}.txt")
REGEX_URL='^(https?|ftp|file)://[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]\.[-A-Za-z0-9\+&@#/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#/%=~_|]$'
REGEX_ISNUM='^[0-9]+$'

# #
#   Default Values
# #

if [[ "$TEMPL_DESC" == *"404: Not Found"* ]]; then
    TEMPL_DESC="#   No description provided"
fi

if [[ "$TEMPL_CAT" == *"404: Not Found"* ]]; then
    TEMPL_CAT="Uncategorized"
fi

if [[ "$TEMPL_EXP" == *"404: Not Found"* ]]; then
    TEMPL_EXP="6 hours"
fi

if [[ "$TEMP_URL_SRC" == *"404: Not Found"* ]]; then
    TEMP_URL_SRC="None"
fi

# #
#   Output > Header
# #

echo -e
echo -e " ──────────────────────────────────────────────────────────────────────────────────────────────"
echo -e "  Blocklist -  ${APP_FILE_PERM} (${ARG_BLOCKS_CAT})"
echo -e "  ID:          ${TEMPL_ID}"
echo -e "  UUID:        ${TEMPL_UUID}"
echo -e "  CATEGORY:    ${TEMPL_CAT}"
echo -e "  ACTION:      ${APP_FILE}"
echo -e " ──────────────────────────────────────────────────────────────────────────────────────────────"

# #
#   output
# #

echo -e
echo -e "  ⭐ Starting"

# #
#   Create or Clean file
# #

if [ -f $APP_FILE_PERM ]; then
    echo -e "  📄 Clean ${APP_FILE_PERM}"
    echo -e
   > ${APP_FILE_PERM}       # clean file
else
    echo -e "  📁 Create ${APP_FILE_PERM}"
    echo -e
    mkdir -p $(dirname "${APP_FILE_PERM}")
    touch ${APP_FILE_PERM}
fi

# #
#   Add Static Files
# #

if [ -d .github/blocks/ ]; then
	for APP_FILE_TEMP in .github/blocks/${ARG_BLOCKS_CAT}/*.ipset; do
		echo -e "  📒 Adding static file ${APP_FILE_TEMP}"

        # #
        #   calculate how many IPs are in a subnet
        #   if you want to calculate the USABLE IP addresses, subtract -2 from any subnet not ending with 31 or 32.
        #   
        #   for our purpose, we want to block them all in the event that the network has reconfigured their network / broadcast IPs,
        #   so we will count every IP in the block.
        # #

        BLOCKS_COUNT_TOTAL_IP=0
        BLOCKS_COUNT_TOTAL_SUBNET=0

        for line in $(cat ${APP_FILE_TEMP}); do

            # is ipv6
            if [ "$line" != "${line#*:[0-9a-fA-F]}" ]; then
                if [[ $line =~ /[0-9]{1,3}$ ]]; then
                    COUNT_TOTAL_SUBNET=$(( $COUNT_TOTAL_SUBNET + 1 ))                       # GLOBAL count subnet
                    BLOCKS_COUNT_TOTAL_SUBNET=$(( $BLOCKS_COUNT_TOTAL_SUBNET + 1 ))         # LOCAL count subnet
                else
                    COUNT_TOTAL_IP=$(( $COUNT_TOTAL_IP + 1 ))                               # GLOBAL count ip
                    BLOCKS_COUNT_TOTAL_IP=$(( $BLOCKS_COUNT_TOTAL_IP + 1 ))                 # LOCAL count ip
                fi

            # is subnet
            elif [[ $line =~ /[0-9]{1,2}$ ]]; then
                ips=$(( 1 << (32 - ${line#*/}) ))

                if [[ $ips =~ $REGEX_ISNUM ]]; then
                    # CIDR=$(echo $line | sed 's:.*/::')

                    # uncomment if you want to count ONLY usable IP addresses
                    # subtract - 2 from any cidr not ending with 31 or 32
                    # if [[ $CIDR != "31" ]] && [[ $CIDR != "32" ]]; then
                        # BLOCKS_COUNT_TOTAL_IP=$(( $BLOCKS_COUNT_TOTAL_IP - 2 ))
                        # COUNT_TOTAL_IP=$(( $COUNT_TOTAL_IP - 2 ))
                    # fi

                    BLOCKS_COUNT_TOTAL_IP=$(( $BLOCKS_COUNT_TOTAL_IP + $ips ))              # LOCAL count IPs in subnet
                    BLOCKS_COUNT_TOTAL_SUBNET=$(( $BLOCKS_COUNT_TOTAL_SUBNET + 1 ))         # LOCAL count subnet

                    COUNT_TOTAL_IP=$(( $COUNT_TOTAL_IP + $ips ))                            # GLOBAL count IPs in subnet
                    COUNT_TOTAL_SUBNET=$(( $COUNT_TOTAL_SUBNET + 1 ))                       # GLOBAL count subnet
                fi

            # is normal IP
            elif [[ $line =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
                BLOCKS_COUNT_TOTAL_IP=$(( $BLOCKS_COUNT_TOTAL_IP + 1 ))
                COUNT_TOTAL_IP=$(( $COUNT_TOTAL_IP + 1 ))
            fi
        done

        # #
        #   Count lines and subnets
        # #

        COUNT_LINES=$(wc -l < ${APP_FILE_TEMP})                                             # GLOBAL count ip lines
        COUNT_LINES=$(printf "%'d" "$COUNT_LINES")                                          # GLOBAL add commas to thousands
        COUNT_TOTAL_IP=$(printf "%'d" "$COUNT_TOTAL_IP")                                    # GLOBAL add commas to thousands
        COUNT_TOTAL_SUBNET=$(printf "%'d" "$COUNT_TOTAL_SUBNET")                            # GLOBAL add commas to thousands

        BLOCKS_COUNT_TOTAL_IP=$(printf "%'d" "$BLOCKS_COUNT_TOTAL_IP")                      # LOCAL add commas to thousands
        BLOCKS_COUNT_TOTAL_SUBNET=$(printf "%'d" "$BLOCKS_COUNT_TOTAL_SUBNET")              # LOCAL add commas to thousands

        echo -e "  🚛 Move ${APP_FILE_TEMP} to ${APP_FILE_PERM}"
        cat ${APP_FILE_TEMP} >> ${APP_FILE_PERM}                                            # copy .tmp contents to real file

        echo -e "  ➕ Added ${BLOCKS_COUNT_TOTAL_IP} IPs and ${BLOCKS_COUNT_TOTAL_SUBNET} Subnets to ${APP_FILE_TEMP}"
        echo -e
	done
fi

# #
#   Sort
#       - sort lines numerically and create .sort file
#       - move re-sorted text from .sort over to real file
#       - remove .sort temp file
# #

APP_OUT=$(cat ${APP_FILE_PERM} | grep -v "^#" | sort -n | awk '{if (++dup[$0] == 1) print $0;}' > ${APP_FILE_PERM}.sort)
sed -i 's/[[:blank:]]*$//' ${APP_FILE_PERM}.sort
> ${APP_FILE_PERM}
cat ${APP_FILE_PERM}.sort >> ${APP_FILE_PERM}
rm ${APP_FILE_PERM}.sort

# #
#   ed
#       0a  top of file
# #

ed -s ${APP_FILE_PERM} <<END_ED
0a
# #
#   🧱 Firewall Blocklist - ${APP_FILE_PERM}
#
#   @url            https://raw.githubusercontent.com/${APP_REPO}/${APP_REPO_BRANCH}/${APP_FILE_PERM}
#   @source         ${TEMP_URL_SRC}
#   @id             ${TEMPL_ID}
#   @uuid           ${TEMPL_UUID}
#   @updated        ${TEMPL_NOW}
#   @entries        ${COUNT_TOTAL_IP} ips
#                   ${COUNT_TOTAL_SUBNET} subnets
#                   ${COUNT_LINES} lines
#   @expires        ${TEMPL_EXP}
#   @category       ${TEMPL_CAT}
#
${TEMPL_DESC}
# #

.
w
q
END_ED

# #
#   Finished
# #

T=$SECONDS
echo -e
printf "  🎌 Finished! %02d days %02d hrs %02d mins %02d secs\n" "$((T/86400))" "$((T/3600%24))" "$((T/60%60))" "$((T%60))"

# #
#   Output
# #

echo -e
echo -e " ──────────────────────────────────────────────────────────────────────────────────────────────"
printf "%-25s | %-30s\n" "  #️⃣  ${APP_FILE_PERM}" "${COUNT_TOTAL_IP} IPs, ${COUNT_TOTAL_SUBNET} Subnets"
echo -e " ──────────────────────────────────────────────────────────────────────────────────────────────"
echo -e
echo -e
echo -e