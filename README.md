# GPU Passthrough Manager
A GUI based tool to aid in passing through graphics cards to virtual machines.

**This program is only compatible with systems that support IOMMU.**

## Build instructions
1. ``git clone https://github.com/uwzis/GPU-Passthrough-Manager``
2. ``gcc ./GPUPassthroughManager.c -o "GPU Passthrough Manager" pkg-config --cflags --libs gtk+-3.0``

*(Makefile/build script coming soon)*
