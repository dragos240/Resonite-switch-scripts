# Resonite-switch-scripts

These scripts are intended to make switching between the current release (pre-splittening) of Resonite and the pre-release (splittening) much easier.

**PLEASE READ THE INSTRUCTIONS SECTION BEFORE PROCEDING**

## How it works

### Scripts included
**setup.sh**: The setup.sh script will perform the following actions, guiding the user and pausing at the correct times to make sure the setup goes correctly:

- Check to see if the repo is in Steam's *common* directory in *steamapps*. This is necessary because of the way relative path creation works. If it's in the wrong place, the script will exit
- If it's in the right place, it will create two directories in the *common* folder called "Resonite-pre" and "Resonite-stable"
- Next it will pause and ask the user to be on the release (stable) branch and will wait for the user's input to make sure the correct set of files is copied. The script can be exited with ctrl+c at this point if for whatever reason the user needs to exit and run the setup script again later
- When the user hits ENTER, the files from the release branch will be copied to "Resonite-stable" and an additional backup directory "Resonite-stable.backup" will be created in the event steam updates at the wrong time (but this shouldn't happen if the user follows the Instructions section correctly)
- It will then ask the user to switch to the pre-release branch and to hit ENTER when the files have downloaded. When the user hits ENTER, it copies the pre-release files into "Resonite-pre" and creates a backup in the same way as before at "Resonite-pre.backup"
- Now that the data has been moved to its respective directories and additional backup directories have been created, it will prompt the user saying it will delete the main "Resonite" folder and will prompt them to hit ENTER when ready. This is totally safe since the script checks on each copy whether the copies that were attempted to be created were indeed created. The prompt is more informational than necessary, but also to give the user more control in case they want to bail out
- Once the user presses ENTER, the Resonite directory with all its files will be deleted and a [symbolic link](https://en.wikipedia.org/wiki/Symbolic_link) will be created and point to the pre-release directory. The user can now launch Resonite either through Steam (not recommended, see instructions section) or with the provided "launch-resonite.sh" script

**launch-resonite.sh**: This script accepts on of two arguments, either "stable" (for the release branch) or "pre" for the pre-release branch. If no argument is given or an invalid argument is provided, the script will exit and tell the user to run it again with either "stable" or "pre". Depending on the argument given, it will either delete the symbolic link and create a new link to the "pre-release" directory or delete the symbolic link and create a new link to the "stable" directory.

## Instructions
1. Open steam and ensure you have "automatic updates" turned to "wait until I launch the game". This is **VERY important** as it gives the launcher the chance to switch the release type before it updates and thus prevents the release files getting overwritten by the pre-release ones
2. Clone the repository into your Steam's "common" folder or download the zip and extract Resonite-switch-scripts-master to the "common" folder. The common folder is usually at `~/.local/share/Steam/steamapps/common` or wherever you installed Resonite to. Just make sure it's in the same "common" folder as your Resonite install, which will be referred to as `COMMON` for the rest of the instructions
3. Open a terminal and navigate to `COMMON`, then run `./Resonite-switch-scripts/bin/setup.sh`. It doesn't actually matter where you open the script from as the paths used for installation are relative to the location of the script, not the current directory.
4. Follow the instructions in the setup script (See the "How it works" if you want to know what happens in detail). It will tell you what you need to do and when
5. Once the setup script has completed, you'll be left with a symbolic link to the pre-release directory and can use the launch script
6. Next, use the launch script at `Resonite-switch-scripts/bin/launch-resonite.sh` with either "pre" (for the prerelease) or "stable" (for the stable release) as its sole argument. It will create a link to the corresponding Resonite directory and launch the game for you. **Please only use the script to launch Resonite while you have this setup installed**. Failure to do so can allow `stable` to be overwritten by the pre-release files!
