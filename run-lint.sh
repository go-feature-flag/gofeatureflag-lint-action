# Reset
GO_FEATURE_FLAG_CLI_DOCKER_TAG="v1"
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

## Get the image of go-feature-flag-cli from source
fmtPrintln "info" "pulling the image of go-feature-flag-cli:${GO_FEATURE_FLAG_CLI_DOCKER_TAG} from source"
docker pull gofeatureflag/go-feature-flag-cli:${GO_FEATURE_FLAG_CLI_DOCKER_TAG}

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
            gofeatureflag/go-feature-flag-cli:${GO_FEATURE_FLAG_CLI_DOCKER_TAG} \
            lint \
            /config/"${configFile}" \
            --format="$2"; } 2>&1)

## Capture the exit code of the linter (must be the first statement after the
## `msg=$(...)` assignment so it reflects the docker run exit code)
lintExitCode=$?

## Expose the linter result as the action's `lint-message` output.
## Empty when the config is valid, the error message otherwise.
## (Reading it requires `continue-on-error: true` on the step, as the action
## still exits non-zero to fail the CI job when linting fails.)
if [[ -n "${GITHUB_OUTPUT}" ]]; then
    if [[ ${lintExitCode} != 0 ]]; then
        {
            echo "lint-message<<__GOFF_EOF__"
            echo "${msg}"
            echo "__GOFF_EOF__"
        } >> "${GITHUB_OUTPUT}"
    else
        echo "lint-message=" >> "${GITHUB_OUTPUT}"
    fi
fi

## Check if the linter has any errors
if [[ ${lintExitCode} != 0 ]]; then
    fmtPrintln "critical" "linting failed"
    fmtPrintln "critical" "$msg"
    exit 1
fi

fmtPrintln "info" "linting passed"
