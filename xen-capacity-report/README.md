# Xen capacity report

1. Run extract-vms.sh against a dom0 in each pool. Save the output as
   extract.csv.

2. Run wrap.sh.

Outputs:

```
Generated: Monday 2015-11-09

Host     VMs UsedCPU FreeCPU UsedRAM FreeRAM UsedDisk FreeDisk
pe320-01   2       3       1       6      10       30      428
pe320-02   3       4       0      14       2       90      368
...
                 81%             73%              33%
```
