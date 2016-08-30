#!/bin/bash

rm ./wrk/*
rm ./patched/*
rm ./patched/.gitignore
rm ./wrk/.gitignore
rm ./original/.gitignore

cp ./original/[SD]SDT*.aml ./wrk/
rm ./wrk/SSDT-*x.aml
cp ./misc/refs.txt ./wrk
rm ./wrk/DSDT?*.aml
rm ./wrk/SSDT-1.aml
rm ./wrk/SSDT-2.aml
cd ./wrk && iasl -da -dl -fe refs.txt *.aml && rm *.aml && rm refs.txt && cd ..

#DSDT
ff=`cd dsdt && ls`
i=0
b=1
cp ./wrk/DSDT.dsl ./patched/DSDT_1.wrk
for f in $ff
do
  ((i++))
  ((b++))
  ./misc/patchmatic ./patched/DSDT_${i}.wrk ./dsdt/$f ./patched/DSDT_${b}.wrk
done
mv ./patched/DSDT_${b}.wrk ./patched/DSDT.dsl
rm ./patched/DSDT_*.wrk

#SSDTs
rm ./wrk/SSDT-3.dsl
ff=`cd ssdt && ls`
ff2=`cd wrk && ls SSDT*`
for f2 in $ff2
do
  name=`basename $f2 .dsl`
  i=0
  b=1
  cp ./wrk/$f2 ./patched/${name}_1.wrk
  for f in $ff
  do
    ((i++))
    ((b++))
    patchmatic ./patched/${name}_${i}.wrk ./ssdt/$f ./patched/${name}_${b}.wrk
  done
  mv ./patched/${name}_${b}.wrk ./patched/$name.dsl
  rm ./patched/${name}_*.wrk
done
#rm ./patched/SSDT-1.dsl
cp ./misc/*.dsl ./patched

mac=`./misc/mac_gen.sh | sed -e 's/-/, 0x/g'`
mac="0x"$mac
cat ./misc/SSDT-NULL-ETH.wrk | sed -e "s/0x11, 0x22, 0x33, 0x44, 0x55, 0x66/$mac/" > ./patched/SSDT-NULL-ETH.dsl

cd ./patched && iasl *.dsl; rm *.hex; rm *.dsl; cd ..
#cd ./patched && iasl *.dsl; rm *.hex;  cd ..
cp ./misc/*.aml ./patched/

rm ./wrk/*

exit 0
