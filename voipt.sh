#!/bin/bash
# phone bridge voip tunnel POC
# assuming /git/trx is place for trx stuff

app_udb_port=1350

listener_address=ujo.guru
listener_user=$USER
listener_ssh_port=2010
listener_tcp_port=10001

sender_address=127.0.0.1
sender_tcp_port=10000

voipt.main () {
    local function=$1 ; shift
    case $function in
            install|open|close|ls|help )
                        voipt.$function $@
                        return $? ;;
                    *)  echo "unknown command $function"
                        return 1 ;;
        esac
}


voipt.open () {
    voipt.start_listener || echo "listener error $?"
    voipt.start_sender || echo "sender error $?"
}


voipt.close () {
    voipt.close_sender || echo "listener error $?"
    voipt.close_listener || echo "sender error $?"
}


voipt.close_listener () {
    gnome-terminal -- ssh -p $listener_ssh_port $listener_user@$listener_address $'pkill rx ; pkill socat'
    return 0
}


voipt.close_sender () {
    gnome-terminal -- pkill tx ; pkill socat
    local pid=$(ps aux | grep ssh | grep "$sender_tcp_port" | tr -s " " | cut -f2 -d " ")
    [[ $pid ]] && kill $pid
    return 0
}


voipt.start_listener () {
    # assuming listener is remote and sender is local
    echo "listener rx"
    gnome-terminal -- ssh -p $listener_ssh_port $listener_user@$listener_address $HOME/git/trx/rx -h $sender_address -p $app_udb_port
    echo "listener tcp>udp"
    gnome-terminal -- ssh -p $listener_ssh_port $listener_user@$listener_address socat tcp4-listen:$listener_tcp_port,reuseaddr,fork UDP:$sender_address:$app_udb_port
    return 0
}


voipt.start_sender () {
    #run listener first**
    echo "sender tx"
    gnome-terminal -- /tmp/trx/tx -h $sender_address -p $app_udb_port
    echo "sender tunnel"
    gnome-terminal -- ssh -L $sender_tcp_port:$sender_address:$listener_tcp_port $listener_user@$listener_address -p $listener_ssh_port
    sleep 3
    echo "sender udp>tcp"
    gnome-terminal -- socat udp4-listen:$app_udb_port,reuseaddr,fork tcp:$sender_address:$sender_tcp_port
    return 0
}


voipt.help () {
    echo  "voipt help "
    echo
    echo   "usage:    $GURU_CALL voipt [ls|open|close|help|install]"
    echo  "commands:"
    echo
    echo  " ls           list of active tunnels "
    echo  " open         open voip tunnel to host "
    echo  " close        close voip tunnel "
    echo  " install      install trx "
    echo  " help         this help "
    echo
    return 0
}


voipt.install () {
    # assume debian
    sudo apt-get install -y libasound2-dev libopus-dev libopus0 libortp-dev libopus-dev libortp-dev wireguard socat || return $?
    cd /tmp
    git clone http://www.pogo.org.uk/~mark/trx.git || return $?
    cd trx
    sed -i 's/ortp_set_log_level_mask(NULL, ORTP_WARNING|ORTP_ERROR);/ortp_set_log_level_mask(ORTP_WARNING|ORTP_ERROR);/g' tx.c
    make && echo "success" || return $?
    return 0
}


if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
        voipt.main $@
        exit $?
    fi

