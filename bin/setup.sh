#!/bin/sh
# Set -e while testing to make sure crashes exit the script
# set -e

script_dir="$(dirname $0)"
reso_dir="${script_dir}/../../Resonite"
reso_pre_dir="${script_dir}/../../Resonite-pre"
reso_stable_dir="${script_dir}/../../Resonite-stable"

create_dirs() {
    echo "Checking dirs..."
    if [ ! -d "$reso_dir" ]; then
        echo "Path $reso_dir for Resonite does not exist"
    else
        echo "Resonite path exists!"
    fi
    echo "Creating dirs for prerelease and stable..."
    mkdir -p "$reso_stable_dir" "$reso_pre_dir"
    echo "Done creating dirs!"
}

copy_stable() {
    echo "Copying stable files to Resonite-stable"
    rsync -av "$reso_dir"/ "$reso_stable_dir"
    if [ ! -f "$reso_stable_dir/steam_appid.txt" ]; then
        echo "Copy was not successful, exiting..."
        exit
    fi
    echo "Copy was successful!"
    echo "Backing up stable to a separate dir (in case steam decides to be weird)..."
    rsync -av "$reso_dir"/ "${reso_stable_dir}.backup"
    if [ ! -f "${reso_stable_dir}.backup/steam_appid.txt" ]; then
        echo "Backup was not successful, exiting..."
        exit
    fi
    echo "Backup was successful!"
}

copy_prerelease() {
    echo "Copying prerelease files to Resonite-pre"
    rsync -av "$reso_dir"/ "$reso_pre_dir"
    if [ ! -f "$reso_pre_dir/Resonite.sh" ]; then
        echo "Copy was not successful, exiting..."
        exit
    fi
    echo "Copy was successful!"
    echo "Backing up prerelease to a separate dir (in case steam decides to be weird)..."
    rsync -av "$reso_dir"/ "${reso_pre_dir}.backup"
    if [ ! -f "${reso_pre_dir}.backup/Resonite.sh" ]; then
        echo "Backup was not successful, exiting..."
        exit
    fi
    echo "Backup was successful!"
}

delete_main_dir() {
    echo "Deleting main Resonite directory since we've made a backup"
    rm -rf "$reso_dir"
}

create_symlink_to_pre_release() {
    echo "Creating symbolic link to pre-release dir..."
    ln -s "$(realpath $reso_pre_dir)" "$(realpath $reso_dir)"
}

echo "This setup script will lead you through setting up Resonite folders for easy version switching"
echo "Before continuing, make sure you are on the STABLE ('None' in Steam's beta folder) branch"

echo "Press ENTER if you are on STABLE and ready to proceed (Ctrl+C can be pressed to exit this script)"
read

create_dirs

copy_stable

echo "Now switch to the prerelease branch and hit ENTER when it has finished downloading"
read

copy_prerelease

echo "Now, we need to delete the Resonite directory in order to create a symbolic link to it. Everything has been backed up so there's no chance of data loss"
echo "But just in case, the script is paused until you press ENTER"
read

delete_main_dir

echo "Finally we're creating a symbolic link from the pre-release folder to the main Resonite path"
create_symlink_to_pre_release

echo "If everything worked okay, you should have a Steam-launchable pre-release link!"
echo "In the event things do NOT launch, please create an issue in the Resonite-switch-script repository"

echo "We're done! When you need to switch versions, use the 'launch-resonite.sh' script with either 'stable' or 'pre' as an argument"
