#!/bin/bash
# Install in /usr/local/bin/inhibit-suspend-on-ssh.sh
# Set up logging
exec 1> >(logger -s -t $(basename $0)) 2>&1
# Function to check for SSH connections
check_ssh() {
    # Look for sshd processes with established connections
    if pgrep -f "sshd:.*@" >/dev/null || \
       ss -t state established '( dport = :22 or sport = :22 )' | grep -q ssh; then
        return 0
    else
        return 1
    fi
}
# Main loop
echo "Starting SSH monitor..."
while true; do
    if check_ssh; then
        echo "Active SSH session detected. Inhibiting suspend..."
        # Use timeout to ensure the inhibit command doesn't hang
        timeout 3600 systemd-inhibit --what=sleep:idle --mode=block --who="ssh-monitor" \
            --why="Active SSH connection" sleep infinity &
        INHIBIT_PID=$!

        # Monitor while SSH is active
        while check_ssh; do
            sleep 30
        done

        # Clean up
        if [ -n "$INHIBIT_PID" ]; then
            kill $INHIBIT_PID 2>/dev/null
        fi
        echo "No active SSH sessions. Suspend allowed."
    fi
    sleep 30
done
