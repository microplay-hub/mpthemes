#!/usr/bin/env bash

# This file is part of the microplay-hub
#
# RetroPie WiringOP Button Config Script by Liontek1985
# for RetroPie and offshoot
#
# The RetroPie Project is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/RetroPie/RetroPie-Setup/master/LICENSE.md
#
# v1.31 - 2023-02-27

rp_module_id="mpthemes"
rp_module_desc="Microplay-hub themes for Emulation Station"
rp_module_repo="git https://github.com/microplay-hub/mpthemes.git master"
rp_module_section="config"
rp_module_section="main"
rp_module_flags="noinstclean !rpi !g1"

function depends_mpthemes() {
    if isPlatform "x11"; then
        getDepends feh
    else
        getDepends fbi
    fi
}

function sources_mpthemes() {
    if [[ -d "$md_inst" ]]; then
        git -C "$md_inst" reset --hard  # ensure that no local changes exist
    fi
    gitPullOrClone "$md_inst"
}

function install_mpthemes() {
    local mptsetup="$scriptdir/scriptmodules/supplementary"
	
    cd "$md_inst"
	
    if [[ ! -f "$configdir/all/$md_id.cfg" ]]; then
        iniConfig "=" '"' "$configdir/all/$md_id.cfg"
        iniSet "CFGTHEMES" "mpcorenxt"		
        iniSet "CFGRES" "1080p"
        iniSet "CFGBODY" "NXT_169"
        iniSet "CFGHELP" "SNES"
    fi
    chown $user:$user "$configdir/all/$md_id.cfg"
	chmod 755 "$configdir/all/$md_id.cfg"
	
#	cp -r -u "mp-themes.sh" "$mptsetup/mp-themes.sh"
    chown -R $user:$user "$mptsetup/mp-themes.sh"
	chmod 755 "$mptsetup/mp-themes.sh"
	rm -r "mp-themes.sh"
}

function remove_mpthemes() {
    rm-r "$configdir/all/$md_id.cfg"
}

function configini_mpthemes() {
	chown $user:$user "$configdir/all/$md_id.cfg"	
    iniConfig "=" '"' "$configdir/all/$md_id.cfg"	
}


function changenxtbody_mpthemes() {
    options=(
        B1 "Change Body to NXT 16:9"
        B2 "Change Body to NXT 4:3"
		X "[current setting: $cfgbody]"
    )
    local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option." 22 86 16)
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

    case "$choice" in
        B1)
			iniSet "CFGBODY" "NXT_169"
			sed -i "11s~.*~<include>./art/layouts/body_nxt_169.xml</include>~" /etc/emulationstation/themes/$cfgthemes/config.xml
            ;;
        B2)
			iniSet "CFGBODY" "NXT_43"
			sed -i "11s~.*~<include>./art/layouts/body_nxt_43.xml</include>~" /etc/emulationstation/themes/$cfgthemes/config.xml
            ;;
    esac
}

function changenxtres_mpthemes() {
    options=(
        R1 "Change Resolution to 1080p (1920x1080)"
        R2 "Change Resolution to 720p (1280x720)"
        R3 "Change Resolution to XGA (1024x768)"
		X "[current setting: $cfgres]"
    )
    local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option." 22 86 16)
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

    case "$choice" in
        R1)
			iniSet "CFGRES" "1080p"
			sed -i "24s~.*~<include>./art/layouts/img_1080p-nxt.xml</include>~" /etc/emulationstation/themes/$cfgthemes/config.xml
            ;;
        R2)
			iniSet "CFGRES" "720p"
			sed -i "24s~.*~<include>./art/layouts/img_720p-nxt.xml</include>~" /etc/emulationstation/themes/$cfgthemes/config.xml
            ;;
		R3)
			iniSet "CFGRES" "xga"
			sed -i "24s~.*~<include>./art/layouts/img_xga-nxt.xml</include>~" /etc/emulationstation/themes/$cfgthemes/config.xml
            ;;
    esac
}

function changethemescfg_mpthemes() {
    options=(
        T1 "Change Config base to MPCORENXT"
        T2 "Change Config base to MPCORENXT-720p"
        T3 "Change Config base to MPCORENXT-4-3"
		X "[current setting: $cfgthemes]"
    )
    local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option." 22 86 16)
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

    case "$choice" in
        T1)
			iniSet "CFGTHEMES" "mpcorenxt"
            ;;
        T2)
			iniSet "CFGTHEMES" "mpcorenxt-720p"
            ;;
		T3)
			iniSet "CFGTHEMES" "mpcorenxt-4-3"
            ;;
    esac
}

function changenxthelp_mpthemes() {
    options=(
        H1 "Change Themes-Buttons to 8BITDO"
        H2 "Change Themes-Buttons to 8BITDO (AB-Swaped)"
        H3 "Change Themes-Buttons to SNES"
        H4 "Change Themes-Buttons to SNES (AB-Swaped)"
        H5 "Change Themes-Buttons to XBOX-ONE"
        H6 "Change Themes-Buttons to XBOX-ONE (AB-Swaped)"
        H7 "Change Themes-Buttons to XBOX-360"
        H8 "Change Themes-Buttons to XBOX-360 (AB-Swaped)"
        H9 "Change Themes-Buttons to Playstation"
        H10 "Change Themes-Buttons to Playstation (AB-Swaped)"
		X "[current setting: $cfghelp]"
    )
    local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option." 22 86 16)
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

    case "$choice" in
        H1)
			iniSet "CFGHELP" "8BITDO"
			sed -i "38s~.*~<include>./art/layouts/help_snes.xml</include>~" /etc/emulationstation/themes/$cfgthemes/config.xml
            ;;
        H2)
			iniSet "CFGHELP" "8BITDO_SWAP"
			sed -i "38s~.*~<include>./art/layouts/help_snes_swap.xml</include>~" /etc/emulationstation/themes/$cfgthemes/config.xml
            ;;
        H3)
			iniSet "CFGHELP" "SNES"
			sed -i "38s~.*~<include>./art/layouts/help_snes.xml</include>~" /etc/emulationstation/themes/$cfgthemes/config.xml
            ;;
        H4)
			iniSet "CFGHELP" "SNES_SWAP"
			sed -i "38s~.*~<include>./art/layouts/help_snes_swap.xml</include>~" /etc/emulationstation/themes/$cfgthemes/config.xml
            ;;
        H5)
			iniSet "CFGHELP" "XBOXONE"
			sed -i "38s~.*~<include>./art/layouts/help_xone.xml</include>~" /etc/emulationstation/themes/$cfgthemes/config.xml
            ;;
        H6)
			iniSet "CFGHELP" "XBOXONE_SWAP"
			sed -i "38s~.*~<include>./art/layouts/help_xone_swap.xml</include>~" /etc/emulationstation/themes/$cfgthemes/config.xml
            ;;
        H7)
			iniSet "CFGHELP" "XBOX360"
			sed -i "38s~.*~<include>./art/layouts/help_x360.xml</include>~" /etc/emulationstation/themes/$cfgthemes/config.xml
            ;;
        H8)
			iniSet "CFGHELP" "XBOX360_SWAP"
			sed -i "38s~.*~<include>./art/layouts/help_x360_swap.xml</include>~" /etc/emulationstation/themes/$cfgthemes/config.xml
            ;;
        H9)
			iniSet "CFGHELP" "PSX"
			sed -i "38s~.*~<include>./art/layouts/help_psx.xml</include>~" /etc/emulationstation/themes/$cfgthemes/config.xml
            ;;
        H10)
			iniSet "CFGHELP" "PSX_SWAP"
			sed -i "38s~.*~<include>./art/layouts/help_psx_swap.xml</include>~" /etc/emulationstation/themes/$cfgthemes/config.xml
            ;;
    esac
}	




function install_theme_mpthemes() {
    local theme="$1"
    local repo="$2"
    local branch="$3"


    if [[ -z "$repo" ]]; then
        repo="RetroPie"
    fi

    if [[ -z "$theme" ]]; then
        theme="carbon"
        repo="RetroPie"
    fi

    local name="$theme"

    if [[ -z "$branch" ]]; then
        # Get the name of the default branch, fallback to 'master' if not found
        branch=$(runCmd git ls-remote --symref --exit-code "https://github.com/$repo/es-theme-$theme.git" HEAD | grep -oP ".*/\K[^\t]+")
        [[ -z "$branch" ]] && branch="master"
    else
        name+="-$branch"
    fi

    mkdir -p "/etc/emulationstation/themes"
    gitPullOrClone "/etc/emulationstation/themes/$name" "https://github.com/$repo/es-theme-$theme.git" "$branch"
}

function uninstall_theme_mpthemes() {
    local theme="$1"
    if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
        rm -rf "/etc/emulationstation/themes/$theme"
    fi
}

function gui_mpthemes() {
    local themes=()

    local themes+=(
        'microplay-hub mpcorenxt'
        'microplay-hub mpcorenxt 720p'
        'microplay-hub mpcorenxt 4-3'
        'microplay-hub mpcore2'
        'microplay-hub mpcore'
    )
    while true; do
	
        iniConfig "=" '"' "$configdir/all/$md_id.cfg"
		
        iniGet "CFGTHEMES"
        local cfgthemes=${ini_value}
        iniGet "CFGRES"
        local cfgres=${ini_value}
        iniGet "CFGBODY"
        local cfgbody=${ini_value}	
        iniGet "CFGHELP"
        local cfghelp=${ini_value}
		
	
        local theme
        local theme_dir
        local branch
        local name

        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        local gallerydir="/etc/emulationstation/es-theme-gallery"
        if [[ -d "$gallerydir" ]]; then
            status+=("i")
        else
            status+=("n")
        fi

        options+=(U "Update all installed themes")
        options+=(
			NXT1 "Change Config Base [$cfgthemes]"		
			NXT2 "Change Body-Aspect for $cfgthemes [$cfgbody]"
            NXT3 "Change Resolution for $cfgthemes [$cfgres]"
			NXT4 "Change Help-Buttons for $cfgthemes [$cfghelp]"
			NXT5 "Manual Edit $cfgthemes [CFG-File]"
            TEK "### Script by Liontek1985 ###"
            )

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            branch="${theme[2]}"
            name="$repo/$theme"
            theme_dir="$theme"
            if [[ -n "$branch" ]]; then
                name+=" ($branch)"
                theme_dir+="-$branch"
            fi
            if [[ -d "/etc/emulationstation/themes/$theme_dir" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $name (installed)")
                installed_themes+=("$theme $repo $branch")
            else
                status+=("n")
                options+=("$i" "Install $name")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
		
        iniConfig "=" '"' "$configdir/all/$md_id.cfg"
		
        iniGet "CFGTHEMES"
        local cfgthemes=${ini_value}
        iniGet "CFGRES"
        local cfgres=${ini_value}
        iniGet "CFGBODY"
        local cfgbody=${ini_value}	
        iniGet "CFGHELP"
        local cfghelp=${ini_value}	
		
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            U)
                for theme in "${installed_themes[@]}"; do
                    theme=($theme)
                    rp_callModule esthemes install_theme "${theme[0]}" "${theme[1]}" "${theme[2]}"
                done
                ;;
            NXT1)
				configini_mpthemes
				changethemescfg_mpthemes
                ;;
            NXT2)
				configini_mpthemes
				changenxtbody_mpthemes
                ;;
            NXT3)
				configini_mpthemes
				changenxtres_mpthemes
                ;;
            NXT4)
				configini_mpthemes
				changenxthelp_mpthemes
                ;;
            NXT5)
				editFile "/etc/emulationstation/themes/$cfgthemes/config.xml"
                ;;
            *)
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
                branch="${theme[2]}"
                name="$repo/$theme"
                theme_dir="$theme"
                if [[ -n "$branch" ]]; then
                    name+=" ($branch)"
                    theme_dir+="-$branch"
                fi
                if [[ "${status[choice]}" == "i" ]]; then
                    options=(1 "Update $name" 2 "Uninstall $name")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 60 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            rp_callModule esthemes install_theme "$theme" "$repo" "$branch"
                            ;;
                        2)
                            rp_callModule esthemes uninstall_theme "$theme_dir"
                            ;;
                    esac
                else
                    rp_callModule esthemes install_theme "$theme" "$repo" "$branch"
                fi
                ;;
        esac
    done
}
