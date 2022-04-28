#!/usr/bin/env sh

BASE_DIR="$( cd -- "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
MII_TESTDATA_BASE_URL=https://github.com/medizininformatik-initiative/kerndatensatz-testdaten/raw/master/Test_Data/Polar
MII_TESTDATA_FILES=(POLAR_Testdaten_Original_UKB-UKB-0001-UKB-0015.json.zip POLAR_Testdaten_Original_UKE-UKE-0001-UKE-0020.json.zip POLAR_Testdaten_Original_UKFAU-UKFAU-0001-UKFAU-0011.json.zip POLAR_Testdaten_Original_UKFR-UKFR-0001-UKFR-0010.json.zip POLAR_Testdaten_Original_UKSH-UKSH-0001-UKSH-0005.json.zip)

for file in "${MII_TESTDATA_FILES[@]}"
do
    wget "$MII_TESTDATA_BASE_URL/$file"
    unzip -o $file -d testdata
    rm $file
done