#!/bin/bash
# shebang for syntax highlighting purposes

# Colors
_NON="\[\033[0m\]"
_BLD="\[\033[1m\]" # YEP BALD
_BLK="\[\033[30m\]"
_RED="\[\033[31m\]"
_GRN="\[\033[32m\]"
_YLW="\[\033[33m\]"
_BLU="\[\033[34m\]"
_PRP="\[\033[35m\]"
_CYN="\[\033[36m\]"
_WHT="\[\033[37m\]"

__debug_trap() {
	# Set necessary pre-command variables (PROMPT_COMMAND is a
	# command so its excluded here)
	if [[ "$BASH_COMMAND" != "$PROMPT_COMMAND"
		&& "$LAST_BASH_COMMAND" == "$PROMPT_COMMAND" ]]; then
		INC_TIME=1
		LAST_RT="$EPOCHREALTIME" # This should be the last thing done in this function
	fi
	LAST_BASH_COMMAND="$BASH_COMMAND"
}

trap '__debug_trap' DEBUG

__get_cmd_time() {
	# Set hours minutes seconds and remove preceding zeros
	local YEAR=$((10#0$(($(TZ=UTC printf '%(%Y)T' $CMD_TIME)))-1970))
	local DAYS=$((10#0$(TZ=UTC printf '%(%j)T' $CMD_TIME)))
	local HOUR=$((10#0$(TZ=UTC printf '%(%H)T' $CMD_TIME)))
	local MINS=$((10#0$(TZ=UTC printf '%(%M)T' $CMD_TIME)))
	local SECS=$((10#0$(TZ=UTC printf '%(%S)T' $CMD_TIME)))

	# Choose whether or not to print hours minutes and seconds
	[[ $CMD_TIME -ge 31536000 ]] && printf '%sy ' ${YEAR}
	[[ $CMD_TIME -ge 86400    ]] && printf '%sd ' ${DAYS}
	[[ $CMD_TIME -ge 3600     ]] && printf '%sh ' ${HOUR}
	[[ $CMD_TIME -ge 60       ]] && printf '%sm ' ${MINS}
	[[ $CMD_TIME -ge 1        ]] && printf '%ss ' ${SECS}
	# If you want to have a limit uncomment the next line and replace somenum with
	# the minimum microseconds
#	[[ $CMD_US   -ge somenum  ]] &&
	                                printf '%sμs' ${CMD_US:-0}
}

__sig() {
	# Giant switch case for getting the name of the signal (`kill -l`)
	j=0
	for i in $@; do
		if [[ $j != 0 ]]; then
			printf '%s|%s' "$_WHT" "$_RED"
		fi
		j=$((j+1))
		case $i in
			126) printf ACCES  ;;
			127) printf NOENT  ;;
			129) printf HUP    ;;
			130) printf INT    ;;
			131) printf QUIT   ;;
			132) printf ILL    ;;
			133) printf TRAP   ;;
			134) printf ABRT   ;;
			135) printf BUS    ;;
			136) printf FPE    ;;
			137) printf KILL   ;;
			138) printf USR1   ;;
			139) printf SEGV   ;;
			140) printf USR2   ;;
			141) printf PIPE   ;;
			142) printf ALRM   ;;
			143) printf TERM   ;;
			144) printf STKFLT ;;
			145) printf CHLD   ;;
			146) printf CONT   ;;
			147) printf STOP   ;;
			148) printf TSTP   ;;
			149) printf TTIN   ;;
			150) printf TTOU   ;;
			151) printf URG    ;;
			152) printf XCPU   ;;
			153) printf XFSZ   ;;
			154) printf VTALRM ;;
			155) printf PROF   ;;
			156) printf WINCH  ;;
			157) printf IO     ;;
			158) printf PWR    ;;
			159) printf SYS    ;;
			16[3-9]|1[7-8][0-9]|19[0-2]) printf RT$(($i-128)) ;; # Savagery
			*)   printf $i     ;; # Print exit code if not in list
		esac
	done
}

__ssh() {
	local CON=($SSH_CONNECTION)
	local SRV_IP="${CON[2]}"
	[[ -z "$SRV_IP" ]] && return
	local SRV_PORT="${CON[3]}"
	# 4 chars from startand 4 chars from end
	local SRV_IP_CUT="${_CYN}${SRV_IP}"
	[[ ${#SRV_IP} -gt 8 ]] && local SRV_IP_CUT="${_CYN}${SRV_IP:0:4}${_WHT}*${_CYN}${SRV_IP: -4}"

	printf '%s' "${_GRN}${_BLU}[${SRV_IP_CUT}${_PRP}${_BLD}:${_NON}${_CYN}${SRV_PORT}${_BLU}]${_NON}"
}

__prompt() {
	# Get exit code (must be first)
	local PLC=(${PIPESTATUS[@]})

	# Reset time when prompt was first displayed after command
	# this contributes to the 40 microsecond difference in $CMD_US and the actual time it took
	if [[ "$INC_TIME" != 0 ]]; then 
		PROMPT_RT="$EPOCHREALTIME"
		INC_TIME=0
	fi

	# *_RT may not be set
	LAST_RT="${LAST_RT:-$EPOCHREALTIME}"
	PROMPT_RT="${PROMPT_RT:-$EPOCHREALTIME}"

	# Get relative times

	# Remove decimal point, simulating multiplying by 1 million
	PROMPT_RT1M="${PROMPT_RT/.}"
	LAST_RT1M="${LAST_RT/.}"

	CMD_US="$(($PROMPT_RT1M-$LAST_RT1M))"

	CMD_TIME=0

	# Remove last 6 chars, simulating dividing by 1 million to get a more accurate difference
	[[ ${#CMD_US} -lt 6 ]] || CMD_TIME="${CMD_US::-6}"

	[[ ${#CMD_US} -lt 6 ]] || CMD_US="${CMD_US: -6}"
	CMD_US="$((10#0$CMD_US))"

	# Set prompt sections

	# Text

	# ssh detection and indicator
	[[ "$SSH_CONNECTION" ]] && local SSH="$(__ssh) "

	# [INT], [4], etc.
	local i
	for i in ${PLC[@]}; do
		if [[ $i > 0 ]]; then
			local SIG="$(printf '%s[%s%s%s] ' "$_BLU" "$_RED" "$(__sig ${PLC[@]})" "$_BLU")"
			break
		fi
	done

	# [user@homeserver:~]
	local COL="$([[ $UID == 0 ]] && printf '%s' "$_RED" || printf '%s' "$_YLW")"
	local UHD="${_BLD}${_BLU}[${COL}\u${_PRP}@${_CYN}\h${_PRP}:${_GRN}\w${_BLU}]"

	# 2y 351d 12m 43s 382969μs
	local TIME="${_YLW}$(__get_cmd_time)"

	# Random colored $ or #
	_RAND256="\[\033[38;2;$((RANDOM%256));$((RANDOM%256));$((RANDOM%256))m\]"
	local IND="${_RAND256}\\$"

	# Set the prompt
	PS1="${_NON}${SSH}${SIG}${UHD} ${TIME} ${IND} ${_NON}"
}
	
PROMPT_COMMAND=__prompt
