#!/bin/bash

let major=1
let minor=0
let patch=0

version_name="$major.$minor.$patch"
#let version_code="($major * 100) + ($minor * 10) + $patch"
let version_code="1"
echo "version_name : $version_name  version_code = $version_code"

server="prod";
buildType="release";

if [[($1 == "d")]]; then
buildType="debug";
elif [[($1 == "p")]]; then
buildType="profile";
fi

if [[($2 == "d")]]; then
server="dev";
elif [[($2 == "s")]]; then
server="stage";
elif [[($2 == "n")]]; then
server="dev_new";
elif [[($2 == "l")]]; then
server="live";
fi

echo "buildType = $buildType"
echo "Server = $server"

if [[($server == "dev")]]; then
flutter build appbundle --$buildType --flavor eimi_dev -t lib/eimi_dev_main.dart --build-name=$version_name --build-number=$version_code --no-tree-shake-icons
cp ./build/app/outputs/bundle/eimi_devRelease/app-eimi_dev-$buildType.aab ./releases/eimi_dev$buildType_$version_name.aab
else
flutter build appbundle --$buildType --flavor eimi_prod -t lib/eimi_prod_main.dart --build-name=$version_name --build-number=$version_code --no-tree-shake-icons
cp ./build/app/outputs/bundle/eimi_prodRelease/app-eimi_prod-$buildType.aab ./releases/eimi_prod$buildType_$version_name.aab
fi


#BEGINCOMMENT
#"./build_eimi_bundle.sh " 1st parameter d/r(debug/release) space 2nd parameter d for dev else prod
#ENDCOMMENT