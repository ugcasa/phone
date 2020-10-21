# Project Phone

How to send audio to another machine by over ssh or other methods.

## trx

this got my nipples to react https://www.pogo.org.uk/~mark/trx/

a little change to tx.c caused probably by some library version issue, but cause problem is one extra null variable for function, it's easier to remove NULL than find out the problem cause.

modification
```c
246	ortp_init();
247	ortp_scheduler_init();
-248	ortp_set_log_level_mask(NULL, ORTP_WARNING|ORTP_ERROR);
+248	ortp_set_log_level_mask(ORTP_WARNING|ORTP_ERROR);
249	session = create_rtp_send(addr, port);
250	assert(session != NULL);
```

one-liner to make the change

```ash
sed -i 's/ortp_set_log_level_mask(NULL, ORTP_WARNING|ORTP_ERROR);/ortp_set_log_level_mask(ORTP_WARNING|ORTP_ERROR);/g' tx.c
```


### test at home

**Receiver**

Linux roima 4.15.0-121-generic #123-Ubuntu SMP Mon Oct 5 16:16:40 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux

	sudo apt-get install -y libasound2-dev libopus-dev libopus0 libortp-dev libopus-dev libortp-dev wireguard
	cd git
	git clone http://www.pogo.org.uk/~mark/trx.git
	cd trx
	sed -i 's/ortp_set_log_level_mask(NULL, ORTP_WARNING|ORTP_ERROR);/ortp_set_log_level_mask(ORTP_WARNING|ORTP_ERROR);/g' tx.c
	make

	sudo ufw allow 1350
	./rx
	trx (C) Copyright 2020 Mark Hills <mark@xwax.org>
	sched_setscheduler: Operation not permitted

OK

**sender**

Linux electra 5.0.0-32-generic #34 18.04.2-Ubuntu SMP Thu Oct 10 10:36:02 UTC 2019 x86_64 x86_64 x86_64 GNU/Linux

	sudo apt-get install libasound2-dev libopus-dev libopus0 libortp-dev libopus-dev libortp-dev wireguard opus-tools
	git clone http://www.pogo.org.uk/~mark/trx.git
	cd trx
	sed -i 's/ortp_set_log_level_mask(NULL, ORTP_WARNING|ORTP_ERROR);/ortp_set_log_level_mask(ORTP_WARNING|ORTP_ERROR);/g' tx.c
	make

	sudo ufw allow 1350
	./tx -h 192.168.1.10

Works


### test in tunnel

- ["SSH protocol run on top of TCP part of the TCP/IP stack. SIP or other type of voip generally runs on top of UDP protocol."](https://superuser.com/questions/699585/why-cant-ssh-tunneling-be-used-for-sip-voip-encryption)
- [Performing UDP tunneling through an SSH connection](https://www.qcnetwork.com/vince/doc/divers/udp_over_ssh_tunnel.html) but quite sure causes latency, thats why udp in first place. 

A reason why 'Connection refused'

The "connection refused" error is coming from the ssh server on server.com when it tries to make the TCP connection to the target of the tunnel. "Connection refused" means that a connection attempt was rejected. The simplest explanation for the rejection is that, on server.com, there's nothing listening for connections on localhost port 8783. In other words, the server software that you were trying to tunnel to isn't running, or else it is running but it's not listening on that port.

Therefore starting orders is important.

**first receiver**

	ssh roima
	socat -h || sudo apt install socat
	cd git/trx ; ./rx -h 127.0.0.1 p 1350 -v2
	socat tcp4-listen:10001,reuseaddr,fork UDP:127.0.0.1:1350

**then sender**

	socat -h || sudo apt install socat
	cd git/trx ; ./tx -h 127.0.0.1 -p 1350
	ssh -v -L 10000:127.0.0.1:10001 casa@ujo.guru -p 2010
	socat udp4-listen:1350,reuseaddr,fork tcp:127.0.0.1:10000

Latency is somewhere between 75 - 150 mS

Test result is passed.


-------

# other tech


## wireguard

https://github.com/WireGuard

## ipsec

https://en.wikipedia.org/wiki/IPsec
hmm tunnelmode https://en.wikipedia.org/wiki/File:Ipsec-modes.svg
wait, this is vpn, why not ssh then?


## UDP data over socks proxy

https://stackoverflow.com/questions/18428498/sending-udp-packets-through-socks-proxy

## voice piped over ssh

hmm ssh tunnel.. yes

https://www.commandlinefu.com/commands/view/350/output-your-microphone-to-a-remote-computers-speaker

worth of test

```bash
arecord -f dat | ssh -C user@host aplay -f dat

```
failed, works, but with 3 sec latency

this might be better, route from sound device to sound device

```bash
arecord --list-devices
# **** List of CAPTURE Hardware Devices ****
# card 0: SB [HDA ATI SB], device 0: ALC889 Analog [ALC889 Analog]
#   Subdevices: 1/1
#   Subdevice #0: subdevice #0
# card 0: SB [HDA ATI SB], device 2: ALC889 Alt Analog [ALC889 Alt Analog]
#   Subdevices: 2/2
#   Subdevice #0: subdevice #0
#   Subdevice #1: subdevice #1

dd if=/dev/snd/pcmC0D0p | ssh -c arcfour -C user@host dd of=/dev/snd/pcmC0D3p
# Unknown cipher type 'arcfour'
# dd: error reading '/dev/snd/pcmC0D0p': Invalid argument
dd if=/dev/snd/pcmC0D0p| ssh -o Ciphers=arcfour -C user@host dd of=/dev/sndpcmC0D0p

#fuck lazy, alld evicefiles pls. failed: none worked
device_list=(pcmC0D0p pcmC0D2c pcmC1D7p pcmC1D9p hwC0D0 pcmC0D0c pcmC0D1p pcmC1D3p pcmC1D8p)
for _device in ${device_list[@]} ; do
	echo "$_device --------------------------"
	dd if=/dev/snd/$_device | ssh -o Ciphers=arcfour -C user@host dd of=/dev/snd/pcmC0D7p &
	sleep 10
done

dd if=/dev/snd/pcmC0D0p| ssh -o Ciphers=arcfour -C user@host dd of=/dev/sndpcmC0D0p
# command-line line 0: Bad SSH2 cipher spec 'arcfour'.
dd if=/dev/snd/pcmC0D0p | ssh -c arcfour -C user@host dd of=/dev/snd/pcmC0D0p
#Unknown cipher type 'arcfour'
dd if=/dev/snd/pcmC0D0p| ssh -C user@host dd of=/dev/sndpcmC0D0p
# dd: failed to open '/dev/sndpcmC0D0p': Permission denied - this shit is hard to walk around

```
**Bad SSH2 cipher spec 'arcfour'**
unusable: https://mgalgs.github.io/2014/10/22/enable-arcfour-and-other-fast-ciphers-on-recent-versions-of-openssh.html

canceled, complicated to select right sound sound device is not as it was at 90's
usually first device is pcmC0D0p, but not Saturdays.. no likelike

padsp is solution on my wine, but is not possible with dd (or is it?)

is fun dough
```bash
# fun virus action: squeaking mouse =P
cat /dev/psaux | padsp tee /dev/audio > /dev/null
```

```bash
arecord -f cd -t raw | oggenc - -r | ssh user@host mplayer -
# failed with 17 sec delay
ffmpeg -f alsa -ac 1 -i hw:3 -f ogg - | ssh user@host mplayer - -idle -demuxer ogg
# hw:3: Input/output error, same with  hw:0  hw:1  hw:2

# padsp starts the specified program and redirects its access to OSS compatible audio devices (/dev/dsp and auxiliary devices) to a PulseAudio sound server.
padsp tee /dev/audio

cat /dev/psaux | ssh -C user@host padsp tee /dev/audio
# works

arecord | ssh -C user@host padsp tee /dev/audio
#best with 2 sec delay


```


## Conclusion

### piping over ssh good only for demo

Too much delay for daily use, some bad quality issues and ripples.

Looked straight forward method to just pipe shit in, but valid only for demo or poc usage.

**method 1**

	arecord -f dat | ssh -C user@host aplay -f dat

- good quality, able to listen
- extra sounds (like volume tune beep) makes audio ripple (like whatsapp sometimes)
- 3 second latency

**method 2**

	arecord -f cd -t raw | oggenc - -r | ssh user@host mplayer -

- 4 sec delay (better then last test, 17 sec)
- extra sound make more latency to audio

**method 3**

	arecord | ssh -C user@host padsp tee /dev/audio

- 2 sec delay
- worst sound quality, like a phone
- extra sounds might lost audio or cause sound to be parted
- messy, better: $(arecord | ssh -C user@host padsp tee /dev/audio) and tolerate "bash: warning: command substitution: ignored null byte in input "

all methods have problems in out application, continue to research
Ask from casa for more detailed log of tests if interested (in notes 19.10.2020).


### rtx + socat + ssh POC - passed

VOIP uses UDP, and tunneling only possible with TCP, so lets stuff UDP traffic to TCP package with socat and tunnel it anywhere we like to.
Lest on LAN latency is on decent level, somewhere between 75 and 150 mS recording the measurement done with android sound oscilloscope.
Latency tests needed top be done on mobile connection.

install socat

	sudo socat -h || sudo apt install socat

Run order is important.

**first receiver**

	cd git/trx ; ./rx -h 127.0.0.1 p 1350 -v2
	socat tcp4-listen:10001,reuseaddr,fork UDP:127.0.0.1:1350

**then sender**

	socat -h || sudo apt install socat
	cd git/trx ; ./tx -h 127.0.0.1 -p 1350
	ssh -v -L 10000:127.0.0.1:10001 casa@ujo.guru -p 2010
	socat udp4-listen:1350,reuseaddr,fork tcp:127.0.0.1:10000

