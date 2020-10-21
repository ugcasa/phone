# Project Phone

How to send audio to another machine by over ssh or other methods.

## voip tech

this got my nipples to react https://www.pogo.org.uk/~mark/trx/

like to try this, but got erron in compile

	git clone http://www.pogo.org.uk/~mark/trx.git
	sudo apt-get install libasound2-dev libopus-dev libopus0 libortp-dev
	cd trx
	make
	make install

hmm.. I cannot fix this.
same with gz downloaded from page

		casa@electra:~/git/trials/trx-0.5$ make
		cc -MMD -Wall   -c -o rx.o rx.c
		rx.c: In function ‘create_rtp_recv’:
		rx.c:58:6: warning: passing argument 3 of ‘rtp_session_signal_connect’ from incompatible pointer type [-Wincompatible-pointer-types]
		      timestamp_jump, 0) != 0)
		      ^~~~~~~~~~~~~~
		In file included from /usr/include/ortp/ortp.h:68:0,
		                 from rx.c:24:
		/usr/include/ortp/rtpsession.h:271:17: note: expected ‘RtpCallback {aka void (*)(struct _RtpSession *)}’ but argument is of type ‘void (*)(RtpSession *, void *, void *, void *) {aka void (*)(struct _RtpSession *, void *, void *, void *)}’
		 ORTP_PUBLIC int rtp_session_signal_connect(RtpSession *session,const char *signal_name, RtpCallback cb, unsigned long user_data);
		                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
		cc -MMD -Wall   -c -o device.o device.c
		cc -MMD -Wall   -c -o sched.o sched.c
		cc   rx.o device.o sched.o  -lasound -lopus -lortp -o rx
		cc -MMD -Wall   -c -o tx.o tx.c
		tx.c: In function ‘main’:
		tx.c:248:26: warning: passing argument 1 of ‘ortp_set_log_level_mask’ makes integer from pointer without a cast [-Wint-conversion]
		  ortp_set_log_level_mask(NULL, ORTP_WARNING|ORTP_ERROR);
		                          ^~~~
		In file included from /usr/include/ortp/ortp.h:67:0,
		                 from tx.c:24:
		/usr/include/ortp/logging.h:67:18: note: expected ‘int’ but argument is of type ‘void *’
		 ORTP_PUBLIC void ortp_set_log_level_mask(int levelmask);
		                  ^~~~~~~~~~~~~~~~~~~~~~~
		tx.c:248:2: error: too many arguments to function ‘ortp_set_log_level_mask’
		  ortp_set_log_level_mask(NULL, ORTP_WARNING|ORTP_ERROR);
		  ^~~~~~~~~~~~~~~~~~~~~~~
		In file included from /usr/include/ortp/ortp.h:67:0,
		                 from tx.c:24:
		/usr/include/ortp/logging.h:67:18: note: declared here
		 ORTP_PUBLIC void ortp_set_log_level_mask(int levelmask);
		                  ^~~~~~~~~~~~~~~~~~~~~~~
		<builtin>: recipe for target 'tx.o' failed
		make: *** [tx.o] Error 1

it too interesting, can it be more clearer?:

	tx -h roima 		       # send audio from default soundcard to the given host
	rx                         # receive audio and play it

help needed! in the meanwhile other methods..


## Test on Windows 10 Home WSL Ubuntu 20.04

```
  824  git clone http://www.pogo.org.uk/~mark/trx.git
  825  cd trx/
  826  ls
  827  less README
  830  make
  831  sudo apt-get install libasound2-dev libopus-dev libopus0 libortp-dev
  832  sudo apt-get update
  833  sudo apt-get install libasound2-dev libopus-dev libopus0 libortp-dev
  834  sudo apt-get install libasound2-dev
  835  make
  836  sudo apt-get install  libopus-dev
  837  make
  838  sudo apt-get install  libortp-dev
  839  make
timo@Osiris:~/trx$ ./tx
trx (C) Copyright 2020 Mark Hills <mark@xwax.org>
2020-10-21 00:09:54:023 ortp-error-Fail to set DSCP value on rtp socket: Operation not permitted
2020-10-21 00:09:54:023 ortp-error-Fail to set DSCP value on rtcp socket: Operation not permitted
2020-10-21 00:09:54:024 ortp-error-Fail to set DSCP value on rtp socket: Operation not permitted
2020-10-21 00:09:54:024 ortp-error-Fail to set DSCP value on rtcp socket: Operation not permitted
Aborted (core dumped)
timo@Osiris:~/trx$ ./rx
trx (C) Copyright 2020 Mark Hills <mark@xwax.org>
shared memfd open() failed: Function not implemented
ALSA lib confmisc.c:767:(parse_card) cannot find card '0'
ALSA lib conf.c:4732:(_snd_config_evaluate) function snd_func_card_driver returned error: No such file or directory
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:4732:(_snd_config_evaluate) function snd_func_concat returned error: No such file or directory
ALSA lib confmisc.c:1246:(snd_func_refer) error evaluating name
ALSA lib conf.c:4732:(_snd_config_evaluate) function snd_func_refer returned error: No such file or directory
ALSA lib conf.c:5220:(snd_config_expand) Evaluate error: No such file or directory
ALSA lib pcm.c:2642:(snd_pcm_open_noupdate) Unknown PCM default
snd_pcm_open: No such file or directory
timo@Osiris:~/trx$ ./rx
trx (C) Copyright 2020 Mark Hills <mark@xwax.org>
shared memfd open() failed: Function not implemented
ALSA lib confmisc.c:767:(parse_card) cannot find card '0'
ALSA lib conf.c:4732:(_snd_config_evaluate) function snd_func_card_driver returned error: No such file or directory
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:4732:(_snd_config_evaluate) function snd_func_concat returned error: No such file or directory
ALSA lib confmisc.c:1246:(snd_func_refer) error evaluating name
ALSA lib conf.c:4732:(_snd_config_evaluate) function snd_func_refer returned error: No such file or directory
ALSA lib conf.c:5220:(snd_config_expand) Evaluate error: No such file or directory
ALSA lib pcm.c:2642:(snd_pcm_open_noupdate) Unknown PCM default
snd_pcm_open: No such file or directory
timo@Osiris:~/trx$ ls
COPYING   README      device.c  device.h  notice.h  rx.c  rx.o     sched.d  sched.o  tx.c  tx.o
Makefile  defaults.h  device.d  device.o  rx        rx.d  sched.c  sched.h  tx       tx.d
timo@Osiris:~/trx$
timo@Osiris:~/trx$ ./rx
trx (C) Copyright 2020 Mark Hills <mark@xwax.org>
shared memfd open() failed: Function not implemented
ALSA lib confmisc.c:767:(parse_card) cannot find card '0'
ALSA lib conf.c:4732:(_snd_config_evaluate) function snd_func_card_driver returned error: No such file or directory
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:4732:(_snd_config_evaluate) function snd_func_concat returned error: No such file or directory
ALSA lib confmisc.c:1246:(snd_func_refer) error evaluating name
ALSA lib conf.c:4732:(_snd_config_evaluate) function snd_func_refer returned error: No such file or directory
ALSA lib conf.c:5220:(snd_config_expand) Evaluate error: No such file or directory
ALSA lib pcm.c:2642:(snd_pcm_open_noupdate) Unknown PCM default
snd_pcm_open: No such file or directory
timo@Osiris:~/trx$ ./tx
trx (C) Copyright 2020 Mark Hills <mark@xwax.org>
2020-10-21 00:18:48:955 ortp-error-Fail to set DSCP value on rtp socket: Operation not permitted
2020-10-21 00:18:48:956 ortp-error-Fail to set DSCP value on rtcp socket: Operation not permitted
2020-10-21 00:18:48:956 ortp-error-Fail to set DSCP value on rtp socket: Operation not permitted
2020-10-21 00:18:48:956 ortp-error-Fail to set DSCP value on rtcp socket: Operation not permitted
Aborted (core dumped)
timo@Osiris:~/trx$ sudo ./tx
[sudo] password for timo:
trx (C) Copyright 2020 Mark Hills <mark@xwax.org>
2020-10-21 00:18:54:250 ortp-error-Fail to set DSCP value on rtp socket: Operation not permitted
2020-10-21 00:18:54:251 ortp-error-Fail to set DSCP value on rtcp socket: Operation not permitted
2020-10-21 00:18:54:251 ortp-error-Fail to set DSCP value on rtp socket: Operation not permitted
2020-10-21 00:18:54:252 ortp-error-Fail to set DSCP value on rtcp socket: Operation not permitted
Aborted (core dumped)
```


## test debian

Linux lassila 4.19.0-10-amd64 #1 SMP Debian 4.19.132-1 (2020-07-24) x86_64 GNU/Linux

	sudo apt-get update
	sudo apt-get install libasound2-dev libopus-dev libopus0 libortp-dev libopus-dev libortp-dev
	git clone http://www.pogo.org.uk/~mark/trx.git
	cd trx
	make
	cc -MMD -Wall   -c -o rx.o rx.c
	cc -MMD -Wall   -c -o device.o device.c
	cc -MMD -Wall   -c -o sched.o sched.c
	cc   rx.o device.o sched.o  -lasound -lopus -lortp -o rx
	cc -MMD -Wall   -c -o tx.o tx.c
	cc   tx.o device.o sched.o  -lasound -lopus -lortp -o tx

	./tx -h 192.168.2.64
	trx (C) Copyright 2020 Mark Hills <mark@xwax.org>
	sched_setscheduler: Operation not permitted

running, good sing!


### other side

Linux latindude 4.15.0-20-generic #21-Ubuntu SMP Tue Apr 24 06:16:15 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux

	1177  sudo apt-get update
	1178  cd git/
	1179  ls
	1180  sudo apt-get install libasound2-dev libopus-dev libopus0 libortp-dev libopus-dev libortp-dev
	1181  git clone http://www.pogo.org.uk/~mark/trx.git
	1182  cd trx
	1183  make


	cc -MMD -Wall   -c -o rx.o rx.c
	rx.c: In function ‘create_rtp_recv’:
	rx.c:58:6: warning: passing argument 3 of ‘rtp_session_signal_connect’ from incompatible pointer type [-Wincompatible-pointer-types]
	      timestamp_jump, 0) != 0)
	      ^~~~~~~~~~~~~~
	In file included from /usr/include/ortp/ortp.h:68:0,
	                 from rx.c:24:
	/usr/include/ortp/rtpsession.h:271:17: note: expected ‘RtpCallback {aka void (*)(struct _RtpSession *)}’ but argument is of type ‘void (*)(RtpSession *, void *, void *, void *) {aka void (*)(struct _RtpSession *, void *, void *, void *)}’
	 ORTP_PUBLIC int rtp_session_signal_connect(RtpSession *session,const char *signal_name, RtpCallback cb, unsigned long user_data);
	                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
	cc -MMD -Wall   -c -o device.o device.c
	cc -MMD -Wall   -c -o sched.o sched.c
	cc   rx.o device.o sched.o  -lasound -lopus -lortp -o rx
	cc -MMD -Wall   -c -o tx.o tx.c
	tx.c: In function ‘main’:
	tx.c:248:26: warning: passing argument 1 of ‘ortp_set_log_level_mask’ makes integer from pointer without a cast [-Wint-conversion]
	  ortp_set_log_level_mask(NULL, ORTP_WARNING|ORTP_ERROR);
	                          ^~~~
	In file included from /usr/include/ortp/ortp.h:67:0,
	                 from tx.c:24:
	/usr/include/ortp/logging.h:67:18: note: expected ‘int’ but argument is of type ‘void *’
	 ORTP_PUBLIC void ortp_set_log_level_mask(int levelmask);
	                  ^~~~~~~~~~~~~~~~~~~~~~~
	tx.c:248:2: error: too many arguments to function ‘ortp_set_log_level_mask’
	  ortp_set_log_level_mask(NULL, ORTP_WARNING|ORTP_ERROR);
	  ^~~~~~~~~~~~~~~~~~~~~~~
	In file included from /usr/include/ortp/ortp.h:67:0,
	                 from tx.c:24:
	/usr/include/ortp/logging.h:67:18: note: declared here
	 ORTP_PUBLIC void ortp_set_log_level_mask(int levelmask);
	                  ^~~~~~~~~~~~~~~~~~~~~~~
	<builtin>: recipe for target 'tx.o' failed
	make: *** [tx.o] Error 1

damn..

okay, last time upgraded 2019-10-17

	sudo apt-get install wireguard

	casa@latindude:~/git/trx$ make
	cc -MMD -Wall   -c -o tx.o tx.c
	tx.c: In function ‘main’:
	tx.c:248:26: warning: passing argument 1 of ‘ortp_set_log_level_mask’ makes integer from pointer without a cast [-Wint-conversion]
	  ortp_set_log_level_mask(NULL, ORTP_WARNING|ORTP_ERROR);
	                          ^~~~
	In file included from /usr/include/ortp/ortp.h:67:0,
	                 from tx.c:24:
	/usr/include/ortp/logging.h:67:18: note: expected ‘int’ but argument is of type ‘void *’
	 ORTP_PUBLIC void ortp_set_log_level_mask(int levelmask);
	                  ^~~~~~~~~~~~~~~~~~~~~~~
	tx.c:248:2: error: too many arguments to function ‘ortp_set_log_level_mask’
	  ortp_set_log_level_mask(NULL, ORTP_WARNING|ORTP_ERROR);
	  ^~~~~~~~~~~~~~~~~~~~~~~
	In file included from /usr/include/ortp/ortp.h:67:0,
	                 from tx.c:24:
	/usr/include/ortp/logging.h:67:18: note: declared here
	 ORTP_PUBLIC void ortp_set_log_level_mask(int levelmask);
	                  ^~~~~~~~~~~~~~~~~~~~~~~
	<builtin>: recipe for target 'tx.o' failed
	make: *** [tx.o] Error 1

hmm.. https://lists.gnu.org/archive/html/linphone-developers/2016-01/msg00041.html
hmm.. https://osmocom.org/projects/osmotrx/wiki/OsmoTRX

hmm.. notices that problem on compile is when tx is copiled.. rx is fine!

	casa@latindude:~/git/trx$ ls
	COPYING  defaults.h  device.c  device.d  device.h  device.o  Makefile  notice.h  README  rx  rx.c  rx.d  rx.o  sched.c  sched.d  sched.h  sched.o  tx.c

so continue testing.

  -p <port>   UDP port number (default 1350)

firewalls, shut down, mic connected

**sender**

	./tx -h 192.168.2.64 -v1
	trx (C) Copyright 2020 Mark Hills <mark@xwax.org>
	No protocol specified
	xcb_connection_has_error() returned true


	sudo apt-get install libasound2-dev libopus-dev libopus0 libortp-dev libopus-dev libortp-dev wireguard

**other end**

	casa@latindude:~/git/trx$ ./rx
	trx (C) Copyright 2020 Mark Hills <mark@xwax.org>
	sched_setscheduler: Operation not permitted

me hearing my self

passed


## test with accesspoint and desktop at home


### not compiling broblem fix

	cc -MMD -Wall   -c -o rx.o rx.c
	rx.c: In function ‘create_rtp_recv’:
	rx.c:58:6: warning: passing argument 3 of ‘rtp_session_signal_connect’ from incompatible pointer type [-Wincompatible-pointer-types]
	      timestamp_jump, 0) != 0)
	      ^~~~~~~~~~~~~~
	In file included from /usr/include/ortp/ortp.h:68:0,
	                 from rx.c:24:
	/usr/include/ortp/rtpsession.h:271:17: note: expected ‘RtpCallback {aka void (*)(struct _RtpSession *)}’ but argument is of type ‘void (*)(RtpSession *, void *, void *, void *) {aka void (*)(struct _RtpSession *, void *, void *, void *)}’
	 ORTP_PUBLIC int rtp_session_signal_connect(RtpSession *session,const char *signal_name, RtpCallback cb, unsigned long user_data);
	                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
	cc -MMD -Wall   -c -o device.o device.c
	cc -MMD -Wall   -c -o sched.o sched.c
	cc   rx.o device.o sched.o  -lasound -lopus -lortp -o rx
	cc -MMD -Wall   -c -o tx.o tx.c
	tx.c: In function ‘main’:
	tx.c:248:26: warning: passing argument 1 of ‘ortp_set_log_level_mask’ makes integer from pointer without a cast [-Wint-conversion]
	  ortp_set_log_level_mask(NULL, ORTP_WARNING|ORTP_ERROR);
	                          ^~~~
	In file included from /usr/include/ortp/ortp.h:67:0,
	                 from tx.c:24:
	/usr/include/ortp/logging.h:67:18: note: expected ‘int’ but argument is of type ‘void *’
	 ORTP_PUBLIC void ortp_set_log_level_mask(int levelmask);
	                  ^~~~~~~~~~~~~~~~~~~~~~~
	tx.c:248:2: error: too many arguments to function ‘ortp_set_log_level_mask’
	  ortp_set_log_level_mask(NULL, ORTP_WARNING|ORTP_ERROR);
	  ^~~~~~~~~~~~~~~~~~~~~~~
	In file included from /usr/include/ortp/ortp.h:67:0,
	                 from tx.c:24:
	/usr/include/ortp/logging.h:67:18: note: declared here
	 ORTP_PUBLIC void ortp_set_log_level_mask(int levelmask);
	                  ^~~~~~~~~~~~~~~~~~~~~~~
	<builtin>: recipe for target 'tx.o' failed
	make: *** [tx.o] Error 1

hmm.. ortp 3.6.1-3build1

ibortp-dev_3.6.1-2.5_amd64.deb

seems that to many variables, new lib old main or other way around?

```c
246	ortp_init();
247	ortp_scheduler_init();
-248	ortp_set_log_level_mask(NULL, ORTP_WARNING|ORTP_ERROR);
+248	ortp_set_log_level_mask(ORTP_WARNING|ORTP_ERROR);
249	session = create_rtp_send(addr, port);
250	assert(session != NULL);
```
Compiles.

one-liner to do change:
	sed -i 's/ortp_set_log_level_mask(NULL, ORTP_WARNING|ORTP_ERROR);/ortp_set_log_level_mask(ORTP_WARNING|ORTP_ERROR);/g' tx.c

passed

### test 2.1 trough tunnel

**Receiver**

Linux roima 4.15.0-121-generic #123-Ubuntu SMP Mon Oct 5 16:16:40 UTC 2020 x86_64 x86_64 x86_64 GNU/Linux


	sudo apt-get install -y libasound2-dev libopus-dev libopus0 libortp-dev libopus-dev libortp-dev wireguard opus-tools
	cd git
	git clone http://www.pogo.org.uk/~mark/trx.git
	cd trx
	sed -i 's/ortp_set_log_level_mask(NULL, ORTP_WARNING|ORTP_ERROR);/ortp_set_log_level_mask(ORTP_WARNING|ORTP_ERROR);/g' tx.c
	make
	cc -MMD -Wall   -c -o tx.o tx.c
	cc   tx.o device.o sched.o  -lasound -lopus -lortp -o tx

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
	cc -MMD -Wall   -c -o tx.o tx.c
	cc   tx.o device.o sched.o  -lasound -lopus -lortp -o tx

	sudo ufw allow 1350
	./tx -h 192.168.1.10

too loud, nice kierto, but worky

OK



### tunnel

dman how it was..

tunnel

	ssh -L 1350:127.0.0.1:1350 -p 2010 casa@ujo.guru

hmm. is this now good or not? cannot remember anymore., =D

sender

	./tx -h 127.0.0.1 -v2
	>>>>>>>>...

receiver

	./rx -v2
	########################################################################################################################################################################################################################################################################################################################################################################################################################################################Short write 1023
	#ALSA lib pcm.c:8306:(snd_pcm_recover) underrun occurred
	############Short write 1639
	#ALSA lib pcm.c:8306:(snd_pcm_recover) underrun occurred
	###########################################################################################################################################################################################################################################################################################################################################################################^C


Receiver react when tunnel is killed by 'Short write'

ssh -L 1350:127.0.0.1:1350 -N -f casa@ujo.guru -p 2010


eh.. shit.. of cause!.. (reason and solution moved to next chapter)


## Solving tcp udp problem

["SSH protocol run on top of TCP part of the TCP/IP stack. SIP or other type of voip generally runs on top of UDP protocol."](https://superuser.com/questions/699585/why-cant-ssh-tunneling-be-used-for-sip-voip-encryption)

**ssh tun on tcp and seems that typically voip is on udp**

Is possible: [Performing UDP tunneling through an SSH connection](https://www.qcnetwork.com/vince/doc/divers/udp_over_ssh_tunnel.html) but quite sure causes latency, thats why udp in first place. 

How complicated it is to test? That guy got it working but did not

.. now i some reason for connection failed: Connection refused

Noice got is finally working

The "connection refused" error is coming from the ssh server on server.com when it tries to make the TCP connection to the target of the tunnel. "Connection refused" means that a connection attempt was rejected. The simplest explanation for the rejection is that, on server.com, there's nothing listening for connections on localhost port 8783. In other words, the server software that you were trying to tunnel to isn't running, or else it is running but it's not listening on that port.

in deed.

therefore starting orders is important

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


latency is somewhere between 75 - 150 mS

passed


-------

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

voip uses udp, and tunneling only possible with tcp, so lets stuck udp to tcp tunnel with socat anywhere we like to. Latency tests needed top be done on mobile connection. Now latency is on decent level, somewhere between 75 and 150 mS recording the measurement done with android sound oscilloscope.

install socat

	sudo socat -h || sudo apt install socat

run order is important.

**first receiver**

	cd git/trx ; ./rx -h 127.0.0.1 p 1350 -v2
	socat tcp4-listen:10001,reuseaddr,fork UDP:127.0.0.1:1350

**then sender**

	socat -h || sudo apt install socat
	cd git/trx ; ./tx -h 127.0.0.1 -p 1350
	ssh -v -L 10000:127.0.0.1:10001 casa@ujo.guru -p 2010
	socat udp4-listen:1350,reuseaddr,fork tcp:127.0.0.1:10000


