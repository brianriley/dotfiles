#!/bin/bash
# Return the number of new emails in the Maildir inbox

maildir="$HOME/Mail/INBOX/new"

if [[ ! -d $maildir ]]; then
	exit 1
fi

nbr_new=$(ls $maildir | wc -l | tr -d ' ')

if [ "$nbr_new" -gt "0" ]; then
	echo "#[bg=red] #[fg=white]✉ ${nbr_new} "
fi

exit 0
