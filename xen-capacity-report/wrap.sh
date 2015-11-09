#!/bin/bash
echo "Host     VMs UsedCPU FreeCPU UsedRAM FreeRAM UsedDisk FreeDisk" \
  && ./summarize.awk extract.csv \
  | awk -F" " '
    NR>1 {
      CPU+=$3;
      TotCPU+=$3+$4;
      RAM+=$5;
      TotRAM+=$5+$6;
      Disk+=$7;
      TotDisk+=$7+$8;
      print
    }
    END {
      printf "%19.0f%% %14.0f%% %15.0f%%\n",
      CPU/TotCPU*100,
      RAM/TotRAM*100,
      Disk/TotDisk*100
    }' \
  | sort -g
