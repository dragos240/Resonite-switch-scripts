#!/bin/sh
# Set -e while testing to make sure crashes exit the script
set -e

script_dir="$(dirname $0)"
reso_dir="${script_dir}/../../Resonite"
reso_pre_dir="${script_dir}/../../Resonite-pre"
reso_stable_dir="${script_dir}/../../Resonite-stable"
steamid=2519830

switch_to_release() {
    echo "Switching to stable..."
    rm "$reso_dir"
    ln -s "$(realpath $reso_stable_dir)" "$(realpath $reso_dir)"
    echo "Switched to stable branch, launching..."
    steam steam://run/$steamid
}

switch_to_prerelease() {
    echo "Switching to pre-release..."
    rm "$reso_dir"
    ln -s "$(realpath $reso_pre_dir)" "$(realpath $reso_dir)"
    echo "Switched to pre-release branch, launching..."
    steam steam://run/$steamid
}

if [ -z "$1" ] || [ "$1" != "stable" ] && [ "$1" != "pre" ]; then
    echo "Please launch with either 'stable' or 'pre' as the sole argument"
    exit
fi

if [ "$1" = "stable" ]; then
    switch_to_release
else
    switch_to_prerelease
fi
