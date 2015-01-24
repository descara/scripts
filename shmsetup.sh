#!/bin/bash
page_size=`getconf PAGE_SIZE`
phys_pages=`getconf _PHYS_PAGES`
shmall=`expr $phys_pages / 2`
shmmax=`expr $shmall \* $page_size`
echo kernel.shmmax = $shmmax
echo kernel.shmall = $shmall
echo vm.overcommit_memory = 2
echo vm.swappiness = 0
# If you install CIF on a machine with limited ram and 
# have out of memory issues, uncomment the next line
#echo vm.overcommit_ratio = 100