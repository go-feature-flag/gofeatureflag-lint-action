# Reset
Color_Off='\033[0m'       # Text Reset

# Regular Colors
Black='\033[0;30m'        # Black
Red='\033[0;31m'          # Red
Green='\033[0;32m'        # Green
Yellow='\033[0;33m'       # Yellow
Blue='\033[0;34m'         # Blue
Purple='\033[0;35m'       # Purple
Cyan='\033[0;36m'         # Cyan
White='\033[0;37m'        # White

function fmtPrintln() {
    case "${1}" in
        "debug")
            printf "${Cyan}DEBUG:${Color_Off} ${2}\n"            
        ;;
        "info")
            printf "${Green}INFO:${Color_Off} ${2}\n"
        ;;
        "warning")
            printf "${Yellow}WARNING:${Color_Off} ${2}\n"
        ;;
        "error")
            printf "${Purple}ERROR:${Color_Off} ${2}\n"
        ;;
        "critical")
            printf "${Red}CRITICAL:${Color_Off} ${2}\n"
        ;;
        *)
            printf "${White}UNKNOWN:${Color_Off} ${2}\n"
        ;;
    esac
}

## Input arguments
fmtPrintln "info" "input arguments: $1 and $2"

## Check if the file name or filetype is passed as argument
if [[ -z "$1" || -z "$2" ]]; then
    fmtPrintln "critical" "filename or filetype is not passed as argument"
    exit 1
fi

## Check if the file exists in the given location
if [[ ! -f "$1" ]]; then
    fmtPrintln "critical" "file does not exist in the given location"
    exit 1
fi

## Check if the filetype is yaml or json
if [[ "$2" != "yaml" && "$2" != "json" && "$2" != "toml" ]]; then
    fmtPrintln "critical" "filetype is not yaml, json, or toml"
    exit 1
fi

flagFile="$(pwd)/$1"
configDir=$(dirname "$flagFile")
configFile=$(basename "$flagFile")

## Run the linter against the config file
msg=$( { docker run -v "${configDir}":/config --rm --name gofeatureflag_lint \
            thomaspoignant/go-feature-flag-lint:v1 \
            --input-format="$2" \
            --input-file=/config/"${configFile}"; } 2>&1)


## Check if the linter has any errors
if [[ $? != 0 || ! -z "${msg}" ]]; then
    fmtPrintln "critical" "linting failed"
    fmtPrintln "critical" "$msg"
    exit 1
fi

fmtPrintln "info" "linting passed"