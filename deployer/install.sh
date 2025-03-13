#!/bin/bash

pkgs=("wget" "git" "curl" "unzip")

for pkg in "${pkgs[@]}"; do 

    sudo apt install -y $pkg

done


echo foobar