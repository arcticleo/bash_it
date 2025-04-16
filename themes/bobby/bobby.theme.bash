# shellcheck shell=bash
# shellcheck disable=SC2034 # Expected behavior for themes.

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

function prompt_command() {
    local date_part="$(date +%F)"
    local time_part="$(date +%T)"

    local bold_muted_cyan='\[\e[1;38;2;60;160;160m\]'

    PS1="\n${bold_muted_cyan}${date_part} ${bold_cyan?}${time_part}${reset_color?} "

    if [[ "${THEME_SHOW_CLOCK_CHAR:-}" == "true" ]]; then
        PS1+="$(clock_char) "
    fi

    PS1+="${yellow?}$(ruby_version_prompt) "
    PS1+="${purple?}\u@\h "
    PS1+="${reset_color?}in "
    PS1+="${green?}\w\n"
    PS1+="${bold_cyan?}$(scm_prompt_char_info) "
    PS1+="${green?}→${reset_color?} "
}

: "${THEME_SHOW_CLOCK_CHAR:="true"}"
: "${THEME_CLOCK_CHAR_COLOR:=${red?}}"
: "${THEME_CLOCK_COLOR:=${bold_cyan?}}"
: "${THEME_CLOCK_FORMAT:="%Y-%m-%d %H:%M:%S"}"

safe_append_prompt_command prompt_command
