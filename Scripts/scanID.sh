#!/bin/bash
#first scan to IDs.txt
./Scripts/scan.sh | grep -E 'Audio device|VGA' | tee ./Scripts/IDs.txt
