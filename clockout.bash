#!/bin/bash

test_dependency () {
	if ! command -v "$1" >/dev/null 2>&1; then
		echo "Error: $1 is not installed." >&2
		exit 1
	fi
}
test_dependency "units"

# Test input file
if [ "$1" = '' ]; then
	echo 'Error: no input file provided' >&2
	exit 1
fi
while read -r line ; do
	if ! echo "$line" | grep -E -q '^\S+\s+(2[0-3]|[0-1][0-9]):[0-5][0-9]\s+(2[0-3]|[0-1][0-9]):[0-5][0-9](\s.*)?$'; then
		echo -e "Error: input file has incorrect format on line:\n$line" >&2
		exit 1
	fi
done < "$1"

# Clockout
TOTAL=0
PREVIOUS_STORY=''
PREVIOUS_DURATION=0
SUBTOTAL=0
DATA="$(sort "$1")\n"
echo -e "$DATA" | { while read -r line ; do
	STORY="$(echo "$line" | awk '{print $1}')"
	FROM="$(echo "$line" | awk '{print $2}')"
	TO="$(echo "$line" | awk '{print $3}')"
	COMMENT="$(echo -e "$line" | sed -E 's/\s+/ /g' | cut --delimiter=' ' --fields=1,2,3 --complement)"
	FROM_EPOCH="$(date +%s --date="$FROM")"
	TO_EPOCH="$(date +%s --date="$TO")"
	DURATION="$(((TO_EPOCH - FROM_EPOCH)/60))"
	TOTAL="$((TOTAL + DURATION))"
	if [ "$STORY" = "$PREVIOUS_STORY" ]; then
		SUBTOTAL="$((SUBTOTAL + DURATION))"
	else
		if [ "$SUBTOTAL" -gt "$PREVIOUS_DURATION" ]; then
			echo -e "└ Subtotal: $SUBTOTAL"
		fi
		if [ "$PREVIOUS_STORY" != '' ]; then
			echo
		fi
		SUBTOTAL="$DURATION"
	fi
	if [ "$line" != '' ]; then
		echo -e "$STORY\t\t\t\t$FROM\t$TO\t$DURATION\t$COMMENT"
	fi
	PREVIOUS_STORY="$STORY"
	PREVIOUS_DURATION="$DURATION"
done
echo -e "Total: $(units "$TOTAL minutes" time)"
}
