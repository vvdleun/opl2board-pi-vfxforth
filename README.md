# opl2-board-pi-vfxforth

A simple library for Raspberry pi, OPL2 audio module board by Dhr Baksteen and VFX Forth for 32-bit ARM Linux (Standard Edition, currently only available commercially and sold by MicroProcessor Engineering company at https://mpeforth.com) users (I bet I'm the only one in the world with this particular setup, but who knows...).

Note that I don't consider myself a good Forth programmer by any means, so do not use those sources to learn Forth. I only dabble in Forth from time to time.

This project requires the following:
* A Raspberry pi (tested on pi 3 only)
* A fully licensed VFX Forth for ARM Linux, Standard Edition
* The awesome OPL2 Audio Module by Dhr Baksteen, sold on Tindie at https://www.tindie.com/products/DhrBaksteen/opl2-audio-board/
* Wiringpi library must be installed (it usually is automatically in Raspbian)

Some of the low-level stuff was directly ported from the C++ library that belongs to the OPL2 Audio Module: https://github.com/DhrBaksteen/ArduinoOPL2

This is work in progress.

Currently there is one demo:
    vfxarmlin "include myfatherscomposition.frt"

My current plans for the short term are:
* Add instrument file support (AdLib INS and BNK formats)
* Create a ROL file player
* Try to add an OPl2 detection routine

For the longer term I hope to create data-structures to create a generic and fully programmable thread-based OPL2 player that can potentially be used for all kinds of formats.

I'll port the library to Java for my adlib-jvm-projects project once this version is feature complete and tested more.

Fun fact: I used the Dutch "Werken Met De Sound Blaster" book, by Josha Munnik and Eric Oostendorp (both of UltraForce fame), published by Sybex in 1992, extensively while developing this library. I got this book as a birthday present in e early '90s when I got my first sound card. Directly programming the FM chip proved to be a little bit too complex to my young brains back then, but that did not stop me from driving the FM chip with the various MS-DOS TSR drivers, using Turbo Pascal. I loved the book so much I always kept it in my bookshelves all those years.

So I'd like to thank Dhr Baksteen for creating the awesome OPL2 board (glad there are many more Yamaha YM3812 and Ad Lib Inc. fans around) and Josha Munnik and Eric Oostendorp for a book they wrote very long ago.
