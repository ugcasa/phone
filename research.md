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

it too interesting, can it be more clearer?:

	tx -h roima 		       # send audio from default soundcard to the given host
	rx                         # receive audio and play it

help needed! in the meanwhile other methods..

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


## Conclusion: good only for demo

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



