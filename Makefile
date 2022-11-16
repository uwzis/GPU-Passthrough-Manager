CC ?= cc
CXX ?= cxx

<< := @echo
ifneq ($(shell eval 'echo -e'),-e)
	<< += -e
endif

all: reboot gpupm apphandler
reboot:
	$(<<) "  CC\ttools/reboot.c"
	@$(CC) tools/reboot.c -o tools/Reboot `pkg-config --cflags --libs gtk+-3.0`

gpupm:
	$(<<) "  CXX\tGPUPM.cpp"
	@$(CXX) GPUPM.cpp -o GPUPM `pkg-config --cflags --libs jsoncpp  gtk+-3.0`

apphandler:
	$(<<) "  CC\ttools/apphandler.c"
	@$(CC) tools/apphandler.c -o gpu-passthrough-manager

clean:
	$(<<) "  RM\t tools/Reboot GPUPM gpu-passthrough-manager" 
	@$(RM) -f tools/Reboot GPUPM gpu-passthrough-manager
