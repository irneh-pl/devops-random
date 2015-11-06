#!/bin/bash
echo "Host     VMs UsedCPU FreeCPU UsedRAM FreeRAM UsedDisk FreeDisk" && ./summarize.awk extract.csv | sort
