#!/bin/bash

eval hostids=($(xe host-list params=uuid | grep . | cut -c 17-))
eval hosts=($(xe host-list params=name-label | grep . | cut -c 23- | sort))
eval cpus=($(xe host-list params=cpu_info | grep . | cut -d : -f 3 | cut -d ";" -f 1 | sed -e 's/^[[:space:]]*//'))
eval memtot=($(xe host-list params=memory-total | grep . | cut -c 25-))
eval memfree=($(xe host-list params=memory-free | grep . | cut -c 25- | sed 's/^0*//'))

i=0
for h in ${hosts[@]}; do
  echo -e "Host Name,CPUs,MemTotal,MemFree\n"
  memtot[$i]=$(bc <<< "scale = 1; ${memtot[$i]} / 1024 / 1024 / 1024")
  memfree[$i]=$(bc <<< "scale = 1; ${memfree[$i]} / 1024 / 1024 / 1024")
  echo -e "$h,${cpus[$i]},${memtot[$i]},${memfree[$i]}\n"
  echo -e "VM Name,vCPUs,Memory GB,Networks,OS,Storage GB,Live\n"
  servers=$(xe vm-list params=uuid resident-on=${hostids[$i]} is-control-domain=false | grep . | cut -c 17-)
  for s in ${servers[@]}; do
    name=$(xe vm-list params=name-label uuid=$s | grep "name-label" | cut -c 23-)
    cpus=$(xe vm-list params=VCPUs-number uuid=$s | grep VCPUs | cut -c 25-)
    memory=$(xe vm-list params=memory-static-max uuid=$s | grep "memory-static-max" | cut -c 30-)
    memory=$(($memory / 1024 / 1024 / 1024))
    networks=$(xe vm-list params=networks uuid=$s | grep -o "[0-9]*\.[0-9]*\.[0-9]*\.[0-9]*" | tr "\n" " ")
    os=$(xe vm-list params=os-version uuid=$s | grep "name" | cut -c 29- | cut -d\; -f1)
    live=$(xe vm-list params=live uuid=$s | grep . | cut -c 17-)

    concat_disks=
    eval disks=($(xe vbd-list vm-uuid=$s type=Disk params=vdi-uuid | grep "vdi-uuid" | cut -c 21-))
    for d in ${disks[@]}; do
      disk_size=$(xe vdi-list uuid=$d params=virtual-size | grep "virtual-size" | cut -c 25-)
      disk_size=$(($disk_size / 1024 / 1024 / 1024))
      sr_name=$(xe vdi-list  uuid=$d params=sr-name-label | grep "sr-name-label" | cut -c 26-)
      disk_size_sr="$sr_name: $disk_size"
      concat_disks=${concat_disks}$disk_size_sr";"
    done
    echo "$name,$cpus,$memory,$networks,$os,$concat_disks,$live"
  done
  i=$((i + 1))
  echo -e '\n'
done
