# Technics GA-series Floppy to USB emulator conversion

## Disclaimer
UNDER NO CIRCUMSTANCES SHALL THE AUTHOR BE LIABLE FOR MATERIAL OR NON-MATERIAL DAMAGES ARISING FROM USE OR DISUSE OF THE PROVIDED INFORMATION OR THE USE OF FAULTY AND INCOMPLETE INFORMATION. THE AUTHOR MAKES NO REPRESENTATIONS OR WARRANTIES WITH RESPECT TO THE ACCURACY OR COMPLETENESS OF THE CONTENTS OF THIS WORK AND SPECIFICALLY DISCLAIMS ALL WARRANTIES, INCLUDING WITHOUT LIMITATION WARRANTIES OF FITNESS FOR A PARTICULAR PURPOSE. THE ADVICE AND STRATEGIES CONTAINED HEREIN MAY NOT BE SUITABLE FOR EVERY SITUATION.

This is not an official guide and I am not affiliated with Technics or the Panasonic Corporation (formerly Matsushita Electric Industrial Co. Ltd.).

## Introduction
Technics GA was one of the last series of electronic organs ever manufactured by Technics in the 1990s. Even today, they are considered very good instruments by many musicians. They were originally equipped with a floppy drive that could read and write 2HD and 2DD 3.5" disks. While floppy disk drives in musical instruments are still used, sometimes even in brand new ones, they do not provide the reliability, speed, data safety and convenience expected nowadays. Because of that, there are efforts to replace floppy drives with emulators that use other media (USB drives, SD cards, ...) but provide the same interface to the device as a floppy drive. This fixes some of the problems, like reliability and data safety. These emulators are also faster in some cases as they usually don't produce read errors as opposed to regular floppy disks.

The Technics GA-series used special floppy drives that did not use the standard IBM PC or Shugart connectors. Instead it used a flat flex cable. Therefore standard floppy emulators can not be used in these organs without modification. Fortunately, the organs used an interace that is logic level compatible and even uses most of the same pins. It is possible to build a fully-passive adapter that connects the emulator and the organ.

This repository contains the information needed to build such an adapter.

## Motivation
The floppy drive in my Technics GA3 broke and any good disk I put in there was unreadable after it had been written to. As getting a replacement drive was expensive or impossible I decided to install a floppy emulator. Someone already made these adapters and was selling them, but unfortunately I was unable to get one.

So I decided to build my own adapter. To do that I had to get the service manual for the organ and a cheap USB floppy emulator (I got a GOTEK SFR1M44-U100K-R).

As stated, the original drive is not connected through a standard floppy cable but a flat flex cable (see images/floppy_drive) which I could not get a connecting plug for, so I did something I did not want to. I had to solder directly to an original Technics circuit board (see images/my_adapter). I guess that's ok as I don't intend to install a floppy drive again, and even if I had to I could unsolder it without damaging the board. I designed a small adapter with a few extra pin headers so I could experiment and rewire them and installed that too. It did not work. As you can see in the pinout of the organ I have 2 unknown pins. None of them were explained in the service manual and apart from the name of the pins I had no more information. So I tried around for a bit but still couldn't get it to work. At some point I gave up. It was not that important and I could live without a working disk drive in my organ for the moment.

Nearly a year later, in February 2016, I searched the internet again and looked at my adapter and the emulator and noticed that I had the wrong jumper settings on the emulator. Apparently it is possible to do some minor configuration on there, like setting to emulate drive A or B and whether to generate a proper READY-signal or not. I changed the jumpers and connected my adapter the right way and it worked!

## Pinout of the organ
The pin numbers 1 and 24 are written on the PCB.

Pin number | Name | Description/Details
---------- | ---- | -------------------
1 | DCH | Could be Disk Change, but is not connected on organ side
2 | INDEX* | Indicates the index hole in the floppy disk
3 | DS0 | Disk select 0
4 | MED*/M.OUT | Unknown
5 | MOT/M.ON | Motor enable
6 | DIR (DS) | Step direction
7 | STEP | Triggers a step
8 | GND | Ground
9 | WDAT/WD | Write data
10 | GND | Ground
11 | WE/WG | Write enable/Write gate
12 | TRK0 | Indicates whether the drive currently is aligned on track 0
13 | WPRT/WPT | Write protection
14 | RDAT/RDA | Read data
15 | GND | Ground
16 | SIDE/1SLT | Side of the floppy for double-sided disks
17 | GND | Ground
18 | GND | Ground
19 | READY/RDY | Ready signal from floppy
20 | +5V | Positive 5V rail
21 | +5V | Positive 5V rail
22 | NC | Not connected
23 | +5V | Positive 5V rail
24 | +5V | Positive 5V rail

The pin names are taken from the official service manual for the organ.

## Pinout of a standard IBM floppy drive
All uneven pins are GND (Ground).

![Floppy pinout](/images/floppy_pinout.png)

Pin number | Name
---------- | ----
2 | Density select
4 | Reserved
6 | Reserved
8 | Index
10 | Motor A
12 | Drive select B
14 | Drive select A
16 | Motor B
18 | Direction
20 | Step
22 | Write data
24 | Write enable/Write gate
26 | Track 0
28 | Write protection
30 | Read data
32 | Head select
34 | Disk change/Ready

## Wiring diagram
![Wiring diagram](/images/wiring.png)

Most emulators only support 1.44 MB floppy disks, that's why pin 2 (Density select) on the emulator is tied to Ground. Simply connect it to one of the GND pins on the organ.

If your floppy emulator does not support generating a READY signal on pin 34 simply connect pin 19 on the organ to ground. In that case however the organ may crash or hang if you try to access the floppy without having a floppy (image) actually loaded in the emulator, so be careful.

In addition to this the floppy emulator also needs power, usually it has a Mini Molex (4 pin) connector of which only the +5V rail is needed. Connect GND (one or both of the pins in the middle) to a GND pin on the organ and the +5V pin to one of the +5V pins on the organ. Additionally, connect at least one (or all of them) of the uneven pins on the floppy emulator to a GND pin. I have never seen that that all were necessary but it's usually a good idea.

## Compatible emulators
I can only confirm that my GOTEK SFR1M44-U100K-R works in my Technics GA3. It was actually sold as a GOTEK SFR1M44-U100K but the firmware states it is a -R model. That is great, because the SFR1M44-U100K is unable to generate a READY-signal that is needed.
