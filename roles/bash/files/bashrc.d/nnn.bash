#
# nnn.bash - sets nnn settings
#

# plugins
plug_gdiff="g:-!git diff"
plug_bashi="s:!bash -i*"
export NNN_PLUG="$plug_gdiff;$plug_bashi"

# nord theme (works well with tokyo night terminal)
# https://github.com/jarun/nnn/wiki/Themes#nord
BLK="0B" CHR="0B" DIR="04" EXE="06" REG="00" HARDLINK="06" SYMLINK="06" MISSING="00" ORPHAN="09" FIFO="06" SOCK="0B" OTHER="06"
export NNN_FCOLORS="$BLK$CHR$DIR$EXE$REG$HARDLINK$SYMLINK$MISSING$ORPHAN$FIFO$SOCK$OTHER"

# sync subshell $PWD
# https://github.com/jarun/nnn/wiki/Basic-use-cases#sync-subshell-pwd
nnn_cd()                                                                                                   
{
    if ! [ -z "$NNN_PIPE" ]; then
        printf "%s\0" "0c${PWD}" > "${NNN_PIPE}" !&
    fi  
}

trap nnn_cd EXIT

