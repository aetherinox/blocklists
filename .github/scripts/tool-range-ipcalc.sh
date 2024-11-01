#!/bin/bash

# #
#    Simple script to take ip ranges, clean them up, and pass them on to ipcalc.
#    Need to create our own in-house script to do the conversion, ipcalc has massive overhead times.
# #

APP_THIS_FILE=$(basename "$0")                          # current script file
APP_THIS_DIR="${PWD}"                                   # Current script directory

# #
#   vars > colors
#
#   Use the color table at:
#       - https://gist.github.com/fnky/458719343aabd01cfb17a3a4f7296797
# #

RESET="\e[0m"
WHITE="\e[97m"
BOLD="\e[1m"
DIM="\e[2m"
UNDERLINE="\e[4m"
BLINK="\e[5m"
INVERTED="\e[7m"
HIDDEN="\e[8m"
BLACK="\e[38;5;0m"
FUCHSIA1="\e[38;5;125m"
FUCHSIA2="\e[38;5;198m"
RED1="\e[38;5;160m"
RED2="\e[38;5;196m"
ORANGE1="\e[38;5;202m"
ORANGE2="\e[38;5;208m"
MAGENTA="\e[38;5;5m"
BLUE1="\e[38;5;033m"
BLUE2="\e[38;5;39m"
CYAN="\e[38;5;6m"
GREEN1="\e[38;5;2m"
GREEN2="\e[38;5;76m"
YELLOW1="\e[38;5;184m"
YELLOW2="\e[38;5;190m"
YELLOW3="\e[38;5;193m"
GREY1="\e[38;5;240m"
GREY2="\e[38;5;244m"
GREY3="\e[38;5;250m"

# #
#   print an error and exit with failure
#   $1: error message
# #

function error()
{
    echo -e "  ⭕ ${GREY2}${APP_THIS_FILE}${RESET}: \n     ${BOLD}${RED}Error${NORMAL}: ${RESET}$1"
    echo -e
    exit 0
}

# #
#   Arguments
#
#   This bash script has the following arguments:
#
#       ARG_SAVEFILE        (str)       file to save IP addresses into
# #

ARG_SAVEFILE=$1
ARG_SOURCEFILE=$2

# #
#   Validation checks
# #

if [[ -z "${ARG_SAVEFILE}" ]]; then
    echo -e
    echo -e "  ⭕ ${YELLOW1}[${APP_THIS_FILE}]${RESET}: No target file specified"
    echo -e
    exit 0
fi

if [[ -z "${ARG_SOURCEFILE}" ]]; then
    echo -e
    echo -e "  ⭕ ${YELLOW1}[${APP_THIS_FILE}]${RESET}: No source file provided -- no ips to convert"
    echo -e
    exit 0
fi

cat "$ARG_SOURCEFILE" |\
while IFS= read ip; do
    ipAddr=$(echo "$ip" | grep -o '[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}-[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}' )
    ipcalc "$ipAddr" -nr |\
    awk '!/^(deaggregate)/'
done