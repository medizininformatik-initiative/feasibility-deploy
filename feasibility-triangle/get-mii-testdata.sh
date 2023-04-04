#!/usr/bin/env bash

MII_TESTDATA_DOWNLOAD_URL="https://health-atlas.de/data_files/594/download?version=1"

wget -O testdata.zip "$MII_TESTDATA_DOWNLOAD_URL"
unzip testdata.zip -d testdata-temp
cd testdata-temp/Vorhofflimmern || exit

for file in *.json.zip
do
    unzip -o "$file" -d ../../testdata
done

cd ../../
rm testdata.zip
rm -rf testdata-temp
