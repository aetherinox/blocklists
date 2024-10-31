# #
#   Test script to calculate number of IPs in list
# #

SECONDS=0                                               # set seconds count for beginning of script
APP_THIS_FILE=$(basename "$0")                          # current script file
APP_FILE=$1                                             # file specified
APP_THIS_DIR="${PWD}"                                   # Current script directory
APP_VER=("1" "1" "0" "0")                               # current version
APP_REPO="Aetherinox/csf-firewall"                      # repository
APP_REPO_BRANCH="main"                                  # repository branch
APP_DIR=${PWD}                                          # returns the folder this script is being executed in
COUNT_LINES=0                                           # number of lines in doc
COUNT_TOTAL_SUBNET=0                                    # number of IPs in all subnets combined
COUNT_TOTAL_IP=0                                        # number of single IPs (counts each line)
BLOCKS_COUNT_TOTAL_IP=0                                 # number of ips for one particular file
BLOCKS_COUNT_TOTAL_SUBNET=0                             # number of subnets for one particular file

# Check Args

if [[ -z "${APP_FILE}" ]]; then
    echo -e "  ⭕ No output file specified for saving by script ${APP_THIS_FILE}"
    echo -e
    exit 1
fi

T=$SECONDS

for line in $(cat ${APP_FILE}); do

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

COUNT_LINES=$(wc -l < ${APP_FILE})                                              # GLOBAL count ip lines
COUNT_LINES=$(printf "%'d" "$COUNT_LINES")                                      # GLOBAL add commas to thousands
COUNT_TOTAL_IP=$(printf "%'d" "$COUNT_TOTAL_IP")                                # GLOBAL add commas to thousands
COUNT_TOTAL_SUBNET=$(printf "%'d" "$COUNT_TOTAL_SUBNET")                        # GLOBAL add commas to thousands

BLOCKS_COUNT_TOTAL_IP=$(printf "%'d" "$BLOCKS_COUNT_TOTAL_IP")                  # LOCAL add commas to thousands
BLOCKS_COUNT_TOTAL_SUBNET=$(printf "%'d" "$BLOCKS_COUNT_TOTAL_SUBNET")          # LOCAL add commas to thousands

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
printf "%-25s | %-30s\n" "  #️⃣  ${APP_FILE}" "${COUNT_TOTAL_IP} IPs, ${COUNT_TOTAL_SUBNET} Subnets"
echo -e " ──────────────────────────────────────────────────────────────────────────────────────────────"
echo -e
echo -e
echo -e