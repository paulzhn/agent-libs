#
# Copyright (c) 2013-2018 Draios Inc. dba Sysdig.
#
# This file is dual licensed under either the MIT or GPL 2. See
# MIT.txt or GPL.txt for full copies of the license.
#

kindling-falcolib-probe-y += main.o dynamic_params_table.o fillers_table.o flags_table.o ppm_events.o ppm_fillers.o event_table.o syscall_table.o ppm_cputime.o
obj-m += kindling-falcolib-probe.o
ccflags-y :=
# VERSION should be replaced by target kernel version
VERSION = $(shell uname -r)
KERNELDIR 		?= /lib/modules/$(VERSION)/build

TOP := $(shell pwd)
all:
	$(MAKE) -C $(KERNELDIR) M=$(TOP) modules

clean:
	$(MAKE) -C $(KERNELDIR) M=$(TOP) clean

install: all
	$(MAKE) -C $(KERNELDIR) M=$(TOP) modules_install