#!/bin/bash

rm -rf .temp
mkdir .temp

wget https://heuristicsecurity.com/dohservers.txt -O .temp/dohservers.txt

cat header.txt >> .temp/dohservers_domains.txt

cat .temp/dohservers.txt | \
grep -oP '(?<=https://).*?(?=[/:])' >> .temp/dohservers_domains.txt

mkdir -p lists/only_domains
cp .temp/dohservers_domains.txt lists/only_domains/dohservers.txt