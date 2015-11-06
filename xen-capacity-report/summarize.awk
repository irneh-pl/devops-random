#!/usr/bin/awk -F, -f
NR>1 {
  HostCPUs[$1]=$2;
  VMs[$1]++;
  vCPUs[$1]+=$8;
  UsedDisk[$1]=$6;
  FreeDisk[$1]=$5-$6;
  UsedRAM[$1]=$3-$4;
  FreeRAM[$1]=$4;
}
END {
  for (i in vCPUs) {
    printf "%s %3s %7s %7.0f %7.0f %7.0f %8.0f %8.0f\n",
           substr(i, 13, 8),
           VMs[i],
           vCPUs[i],
           HostCPUs[i]-vCPUs[i],
           UsedRAM[i],
           FreeRAM[i],
           UsedDisk[i],
           FreeDisk[i]
  }
}
