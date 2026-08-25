# shellcheck shell=bash
# shellcheck disable=SC2034 # Expected behavior for themes.
# Derived from the bobby theme.

SCM_THEME_PROMPT_DIRTY=" ${red?}✗"
SCM_THEME_PROMPT_CLEAN=" ${bold_green?}✓"
SCM_THEME_PROMPT_PREFIX=" ${green?}|"
SCM_THEME_PROMPT_SUFFIX="${green?}|"

GIT_THEME_PROMPT_DIRTY=" ${red?}✗"
GIT_THEME_PROMPT_CLEAN=" ${bold_green?}✓"
GIT_THEME_PROMPT_PREFIX=" ${green?}|"
GIT_THEME_PROMPT_SUFFIX="${green?}|"

RVM_THEME_PROMPT_PREFIX="|"
RVM_THEME_PROMPT_SUFFIX="|"

# Drop base.theme's leading space (' |') so the prompt row keeps single spacing.
RBENV_THEME_PROMPT_PREFIX="|"

function prompt_command() {
    local time_part="$(date +%T)"
    # Compact date like "AUG15": uppercased month abbreviation, day without
    # leading zero (10# arithmetic since BSD date has no %-d).
    local month_part="$(date +%b | tr '[:lower:]' '[:upper:]')"
    local day_part="$((10#$(date +%d)))"
    local week_part="$((10#$(date +%V)))"

    # Same cyan scheme as jelly's progress output: bold bright cyan for the
    # time and the numbers, muted regular cyan for the letter parts.
    # 0; clears any prior attributes (bold would otherwise bleed into the
    # muted parts — SGR 36 alone only changes the color).
    local muted_cyan='\[\e[0;36m\]'
    local bold_bright_cyan='\[\e[1;96m\]'

    PS1="\n${bold_bright_cyan}${time_part} ${muted_cyan}${month_part}${bold_bright_cyan}${day_part} ${muted_cyan}W${bold_bright_cyan}${week_part}${reset_color?} "

    PS1+="${yellow?}$(ruby_version_prompt) "
    PS1+="${purple?}\u@\h"
    PS1+="${reset_color?}:"
    PS1+="${green?}\w\n"
    PS1+="${bold_cyan?}$(scm_prompt_char_info) "
    PS1+="${green?}→${reset_color?} "
}

: "${THEME_SHOW_CLOCK_CHAR:="true"}"
: "${THEME_CLOCK_CHAR_COLOR:=${red?}}"
: "${THEME_CLOCK_COLOR:=${bold_cyan?}}"
: "${THEME_CLOCK_FORMAT:="%Y-%m-%d %H:%M:%S"}"

safe_append_prompt_command prompt_command
