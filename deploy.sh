#!/bin/sh

# Find all files, create links in users home directory (.Xresources, .bashrc, etc)
for filename in $(find ./ -maxdepth 1 -type f | sed 's/.\///'); do
    [[ ! $filename =~ deploy.sh ]] && [ ! -e ~/$filename ] && ln -s ~/.config/.config_git/$filename ~/
    echo $?
    echo "Home Files"
done

# Configure .local/bin/* and .config/* directory links
for directory in $(find ./ -maxdepth 1 -type d | sed 's/.\///'); do
    if [[ $directory =~ .local ]]; then
        scripts=".local/bin"
        for filename in $(find ./$scripts/ -maxdepth 1 | sed 's/.\/.local\/bin\///'); do
            [[ ! -e ~/$scripts/$filename ]] >/dev/null && ln -s ~/.config/.config_git/$scripts/$filename ~/$scripts/
            echo $?
            echo "Local Scripts"
        done
    fi

    # Configure .config directory links
    if [[ $directory =~ .config ]]; then
        for filename in $(find ./$directory/ -maxdepth 1 | sed 's/.\/.config\///'); do
            [[ ! -e ~/$directory/$filename ]] >/dev/null && ln -s ~/.config/.config_git/$directory/$filename ~/$directory/
            echo $?
            echo "Configs"
        done
    fi
done
