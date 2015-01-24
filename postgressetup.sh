#!/bin/bash
page_size=`getconf PAGE_SIZE`
phys_pages=`getconf _PHYS_PAGES`
total_ram_b=`expr $page_size \* $phys_pages`
total_ram_kb=`expr $total_ram_b / 1024`
total_ram_mb=`expr $total_ram_kb / 1024`
ten_percent_total_ram=`expr $total_ram_mb / 10`

work_mem=`expr $total_ram_mb / 8`
shared_buffers=$ten_percent_total_ram
effective_cache_size=`expr $ten_percent_total_ram \* 6`

echo ""
echo ""
echo "#------------------------------------------------------------------------------"
echo "# CIF Setup                                                                    "
echo "#------------------------------------------------------------------------------"
echo "# Rough estimates on how to configured postgres to work with large data sets"
echo "# See the following URL for proper postgres performance tuning"
echo "# http://wiki.postgresql.org/wiki/Tuning_Your_PostgreSQL_Server"
echo "wal_buffers = 12MB" " # recommended range for this value is between 2-16MB"
echo "work_mem = $work_mem""MB" " # minimum 512MB needed for cif_feed"
echo "shared_buffers = $shared_buffers""MB" "# recommended range for this value is 10% on shared db server"
echo "checkpoint_segments = 10" " # at least 10, 32 is a more common value on dedicated server class hardware"
echo "effective_cache_size = $effective_cache_size""MB" " # recommended range for this value is between 60%-80% of your total available RAM"
echo "max_connections = 8" " # limiting to 8 due to high work_mem value"