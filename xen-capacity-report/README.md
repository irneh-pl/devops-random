# Xen capacity report

1. Run extract-vms.sh against a dom0 in each pool. Save the output as
   extract.csv.

2. Run wrap.sh.

Outputs:

```Generated: Monday 2015-11-09

Host     VMs UsedCPU FreeCPU UsedRAM FreeRAM UsedDisk FreeDisk
pe320-01   2       3       1       6      10       30      428
pe320-02   3       4       0      14       2       90      368
pe520-02   9      30       2     110      18      832     1953
pe520-03   8      26       6      86      42     1252     1532
pe520-04   8      26       6      94      34     1007     1778
pe520-05  10      31       1      89       7     2149      636
pe520-06   9      25       7      84      44     1248     1537
pe520-07  10      25       7     113      15     1182     1602
pe520-08   6      17      15      60      68      521     2264
pe520-09   7      26       6      94      34      782     3119
pe520-10   7      24       8      88      40      792     3109
pe520-11  10      27       5      92      36      987     2914
pe520-12   9      28       4      98      30      932     2969
                 81%             73%              33%```
