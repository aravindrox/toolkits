#!/bin/bash

# Copyright 2021 Cloudera, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# Disclaimer
# This script is for training purposes only and is to be used only
# in support of approved training. The author assumes no liability
# for use outside of a training environments. Unless required by
# applicable law or agreed to in writing, software distributed under
# the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES
# OR CONDITIONS OF ANY KIND, either express or implied.

# Title: include.sh
# Author: WKD  
# Date: 1MAR18
# Purpose: Provide a single location for all of the commonly called
# functions. This requires source ${DIR}/bin/include.sh at
# the top of the MAIN for all scripts.

# DEBUG
#set -x
#set -eu
#set >> /tmp/setvar.txt

# VARIABLES
DIR=${HOME}
DATETIME=$(date +%Y%m%d%H%M)
LOGDIR=${DIR}/log

# FUNCTIONS
function check_tgt() {
# Testing for sudo access to root

        klist > /dev/null 2>&1
	RESULT=$?
        if [ $RESULT -ne 0 ]; then
                echo "ERROR: You must have a TGT to run this script. Run kinit."
                usage
        fi
}

function check_root() {
# Testing for root

        if [ "$(id -u)" != 0 ]; then
                echo "ERROR: This script must be run as user root" 1>&2
                usage
        fi
}

function check_sudo() {
# Testing for sudo access to root

        sudo ls /root > /dev/null 2>&1
	RESULT=$?
        if [ $RESULT -ne 0 ]; then
                echo "ERROR: You must have sudo to root to run this script"
                usage
        fi
}

function check_arg() {
# Check if arguments exits

        if [ ${NUMARGS} -ne "$1" ]; then
                usage 
        fi
}

function check_file() {
# Check for a file

        FILE=$1
        if [ ! -f ${FILE} ]; then
                echo "ERROR: Input file ${FILE} not found"
                usage
        fi
}

function check_log_dir() {
# Check if the log dir exists if not make the log dir

	if [ ! -d "${LOGDIR}" ]; then
		mkdir ${LOGDIR}
	fi
}

function setup_log() {
# Check the existance of the log directory and setup the log file.

        check_log_dir

        echo "******LOG ENTRY FOR ${LOGFILE}******" >> ${LOGFILE}
        echo "" >> ${LOGFILE}
}

function yes_no() {
	WORD=$1

        while :; do
                echo -n "${WORD} (y/n)?  "
                read YES_NO junk

                case ${YES_NO} in
                        Y|y|YES|Yes|yes)
                                return 0
                        	;;
                        N|n|NO|No|no)
				return 1
                        	;;
                        *)
                                echo "Enter y or n"
                        	;;
                esac
        done
}

function check_continue() {
# Check if answer is correct and then break from the loop

        if  yes_no "Continue? "; then
		echo 
	else
		exit
	fi
}

function check_pause() {
# A pause statement, used in troubleshooting

	echo -n "Press <ENTER> to continue: "
   	read junk
}

function interrupt() {
# Interrupt codes

        EXITCODE=$1

        echo -e "\nYou have terminated a script."
        echo "Compute jobs will continue to run. If required"
	echo "use yarn to kill running jobs."

        exit ${EXITCODE}
}

function valid_ip() {
# Test an IP address for validity:
# Usage: checkip IP_ADDRESS
#      if [[ $? -eq 0 ]]; then echo good; else echo bad; fi
#      if checkip IP_ADDRESS; then echo good; else echo bad; fi
#

	local  IP=$1
	local  STAT=1

	if [[ ${IP} =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        	OIFS=$IFS
        	IFS='.'
        	IP=($IP)
        	IFS=$OIFS
        	[[ ${IP[0]} -le 255 && ${IP[1]} -le 255 \
            		&& ${IP[2]} -le 255 && ${IP[3]} -le 255 ]]
        		STAT=$?
    	fi
    	return $stat
}

function check_ip() {
# Check if an IP is valid, use validIP function

        validIP ${INPUT1}
        if [ $? -eq 1 ]; then
                echo "ERROR: Incorrect IP address format"
                usage
        fi
}
