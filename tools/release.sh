#!/usr/bin/env bash

VERBOSE=0
REMOVE=0
TIMESTAMP=""
LOGFILE=""
LOCKFILE=""
PART=""
VER_CURRENT=""
VER_NEW=""
MSG=""
BRANCH=""
HASH_CHANGELOG=""
TAG_DATE=""
TAG_MSG=""
PLATFORM=$(uname -s)
GIT_ROOT="$(git rev-parse --show-toplevel)"

usage() {

# MacOS getopt does not support long options, so it gets a different
# usage message. Not worth the time to make this modular, so just copypaste.
if [[ $PLATFORM == "Darwin" ]]; then
cat << EOF
USAGE:
    $0  [ -h ]
    $0  [ -v ] [ -r ] ( -p part )
This script bumps the semantic version and automatically creates
a changelog for releases. It requires bump2version, gitchangelog,
pystache, and git. It must be run from 'main' branch.
ARGS:
    -p  part of the version to increase. Version scheme:
        {major}.{minor}.{patch}-{release}.{build}
OPTIONS:
    -h  Prints this usage information and exits
    -v  Prints verbose messages
    -r  Remove existing lockfiles from previous runs
EX:
    Starting from a current version of 1.0.0:
    Task                        Command                 Version number
    ----                        -------                 --------------
    Start release candidate     $ release -p patch       1.0.1-rc.0
    Added fixes, update RC      $ release -p build       1.0.1-rc.1
    Add More fixes              $ release -p build       1.0.1-rc.2
    Release                     $ release -p release     1.0.1
EOF
else
cat << EOF
USAGE:
    $0  [ -h | --help ]
    $0  [ -v | --verbose ] [ -r | --rm ] ( -p | --part part )
This script bumps the semantic version and automatically creates 
a changelog for releases. It requires bump2version, gitchangelog, 
pystache, and git. It must be run from 'main' branch.
ARGS:
    -p, --part      part of the version to increase. Version scheme:
                    {major}.{minor}.{patch}-{release}
OPTIONS:
    -h, --help      Prints this usage information and exits
    -v, --verbose   Prints verbose messages
    -r, --rm        Remove existing lockfiles from previous runs
EX:
    Starting from a current version of 1.0.0:
    Task                        Command                 Version number
    ----                        -------                 --------------
    Start release candidate     $ release -p release     1.0.1-rc
    Added fixes, update RC      $ release -p patch       1.0.2-rc
    Add More fixes              $ release -p minor       1.0.3-rc
    Release                     $ release -p release     1.0.1

EOF
fi
}

# Set CLI parameters
if [[ $# -lt 2 ]]; then usage; exit; fi

# getopt long options unsupported in MacOS
if [[ $PLATFORM == "Darwin" ]]; then
    ARGS=$(getopt hvrp: "$*")
else
    ARGS=$(getopt -n $0 -o hvrp: -l "help,verbose,rm,part:" -- "$@")
fi

if [[ $? -ne 0 ]]; then usage; exit; fi
eval set --  "$ARGS"
while true; do
    case "$1" in
        -h|--help)
            usage
            exit
        ;;
        -v|--verbose)
            VERBOSE=1
            shift
        ;;
        -r|--rm)
            REMOVE=1
            shift
        ;;
        -p|--part)
            if [[ -n "$2" ]]; then
                PART="$2"
            else
                usage
                exit
            fi
            shift 2
        ;;
        --)
            shift
            break
        ;;
    esac
done

if [[ $PART == "" ]]; then usage; fi

# Set log/lockfiles based on timesatamp
TIMESTAMP=$(date +%Y%m%d.%H%M%S)
LOGFILE="/tmp/release.$TIMESTAMP.log"
LOCKFILE="/tmp/release.$TIMESTAMP.lock"

check_commands() {
    if [[ $VERBOSE -eq 1 ]]; then echo "INFO: check_commands"; fi
    for i in git gitchangelog bump2version; do
        if ! command -v $i &> /dev/null; then
            echo -e "ERROR: $i not found! Exiting"
            exit 1
        fi
    done
}

# Check for existing lockfiles
check_lockfiles() {
    if [[ $VERBOSE -eq 1 ]]; then echo "INFO: check_lockfiles"; fi
    if ls /tmp/release.*.lock 1>/dev/null 2>&1; then
        if [[ $REMOVE -eq 1 ]]; then
            echo "INFO: Removing existing lockfiles!"
            rm -f /tmp/release.*.lock
        else
            echo "ERROR: Lockfile exists in /tmp. See log in /tmp."
            exit 1
        fi
    fi
}

# Get versioning bits
set_versions() {
    if [[ $VERBOSE -eq 1 ]]; then echo "INFO: set_versions"; fi
    set +e
    VER_CURRENT=$(
        bump2version --dry-run --list $PART | \
        grep "^current_version" | awk -F= '{ print $2 }'
    )
    VER_NEW=$(
        bump2version --dry-run --list $PART | \
        grep "^new_version" | awk -F= '{ print $2 }'
    )
    MSG="Bump version: $VER_CURRENT ??? $VER_NEW"
    echo $MSG
    BRANCH=$(git rev-parse --abbrev-ref HEAD)
    set -e
}

# Add CHANGELOG, amend commit, move version tag to amended commit
# gitchangelog requires a pre-existing tagged commit or the section
# name will be "Unreleased".
add_changelog() {
    if [[ $VERBOSE -eq 1 ]]; then echo "INFO: add_changelog"; fi
    MSG_CHANGELOG="$MSG, Added CHANGELOG"
    echo -e "\n=== $MSG_CHANGELOG"
    set -e
    gitchangelog > CHANGELOG.rst
    git add CHANGELOG.rst
    git commit --amend -m "$MSG_CHANGELOG"
    HASH_CHANGELOG=$(git rev-parse HEAD)
    move_tag
    set +e
}

# Move tag to changelog commit
move_tag() {
    if [[ $VERBOSE -eq 1 ]]; then echo "INFO: move_tag"; fi
    TAG_DATE=$(
        git show $VER_NEW | \
        awk '{ if ($1 == "Date:") { print substr($0, index($0, $3)) }}' | \
        tail -2 | head -1
    )
    TAG_MSG=$(
        git show $VER_NEW | \
        awk -v capture=0 '
            { if (capture) msg=msg"\n"$0 }
            BEGIN { msg="" }
            {
                if ($1 == "Date:" && length(msg)==0) {capture=1}
                if ($1 == "commit" ) {capture=0}
            }
            END { print msg }
        ' | sed '$ d' | cat -s
    )
    set -e
    git tag -d $VER_NEW 
    GIT_COMMITTER_DATE=$TAG_DATE \
        git tag -a $VER_NEW -m "$TAG_MSG" $HASH_CHANGELOG 
    set +e
}

# Bump version, commit and tag
bump_version() {
    if [[ $VERBOSE -eq 1 ]]; then echo "INFO: bump_version"; fi
    if [[ $BRANCH == "main" ]]; then
        echo -e "\n=== $MSG"
        touch $LOCKFILE
        {
            set -e
            bump2version "$PART"
            git commit -am "$MSG"
            git tag -a "$VER_NEW" -m "$MSG"
            if [[ $PART == "release" ]]; then add_changelog; fi
            git push origin "$BRANCH" --follow-tags
            set +e
        } 2>&1 | tee -a $LOGFILE
        echo -e "\n=== LOGS: $LOGFILE"
        rm -f $LOCKFILE
    else
        echo -e "ERROR: Branch is $BRANCH! Please run from 'main'."
        exit 1
    fi
}



function check_tagged_submodules {
    echo "Check if all submodules are tagged"
    git submodule update --init --recursive
    git submodule foreach --recursive \
    bash -c 'if [ "$(git tag -l --points-at HEAD)" == "" ] ; \
    then echo "Untagged submodule found. Please make sure all submodules are released. Aborting release procedure." && exit 1 ;\
    else echo "contains tag: $(git tag -l --points-at HEAD)" ;\
    fi'
}

function update_docs {
    cd $GIT_ROOT
    echo "Updating the docs to the new version"
    mkdir -p  docs/src/$VER_NEW
    cp -r docs/src/develop/* docs/src/$VER_NEW/
    sed -i.bak "s/latest: .*/latest: ${VER_NEW}/" docs/src/_config.yml && rm docs/src/_config.yml.bak
    grep 'latest:' <  docs/src/_config.yml
}

# Checking out latest version of main.
cd $GIT_ROOT
echo "Checking out main"
git checkout main
echo "Get latest develop main"
git pull origin main

# Checking if pipeline is ready for release.
check_tagged_submodules


check_commands
check_lockfiles
set_versions
bump_version
update_docs