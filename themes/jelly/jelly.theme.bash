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
    local week_part="w$((10#$(date +%V)))"
    # Compact date like "aug15": lowercased month abbreviation, day without
    # leading zero (10# arithmetic since BSD date has no %-d).
    local date_part="$(date +%b | tr '[:upper:]' '[:lower:]')$((10#$(date +%d)))"

    # Same cyan scheme as jelly's progress output: muted regular cyan for the
    # date, bold bright cyan for the time.
    # 0; clears any prior attributes (the time's bold would otherwise bleed
    # into the week number — SGR 36 alone only changes the color).
    local muted_cyan='\[\e[0;36m\]'
    local bold_bright_cyan='\[\e[1;96m\]'

    PS1="\n${bold_bright_cyan}${time_part} ${muted_cyan}${week_part} ${date_part}${reset_color?} "

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
