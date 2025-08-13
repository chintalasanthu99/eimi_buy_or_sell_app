#!/bin/bash

let major=1
let minor=0
let patch=0

version_name="$major.$minor.$patch"
let version_code="01"
echo "version_name : $version_name  version_code = $version_code"

server="prod"
buildType="release"

# shellcheck disable=SC1035
# Determine the build type (debug/profile/release) based on the first parameter
if [[($1 == "d")]]; then
    buildType="debug"
elif [[($1 == "p")]]; then
    buildType="profile"
fi

# shellcheck disable=SC1035
# Determine the server (dev, stage, new, or live) based on the second parameter
if [[($2 == "d")]]; then
    server="dev"
elif [[($2 == "s")]]; then
    server="stage"
elif [[($2 == "n")]]; then
    server="dev_new"
elif [[($2 == "l")]]; then
    server="live"
fi

echo "buildType = $buildType"
echo "Server = $server"

# Build APK based on server and build type
# For debug builds, we do not include --analyze-size flag
# shellcheck disable=SC1035
if [[($server == "dev")]]; then
    if [[($buildType == "debug")]]; then
        flutter build apk --target-platform android-arm64 --$buildType -t lib/Eimi_dev_main.dart --build-name=$version_name --build-number=$version_code --no-tree-shake-icons
        cp ./build/app/outputs/apk/Eimi_dev/$buildType/app-Eimi_dev-$buildType.apk ./releases/Eimi_dev$buildType_$version_name.apk
    else
        flutter build apk --target-platform android-arm64 --analyze-size --$buildType -t lib/Eimi_dev_main.dart --build-name=$version_name --build-number=$version_code --no-tree-shake-icons
        cp ./build/app/outputs/apk/Eimi_dev/$buildType/app-Eimi_dev-$buildType.apk ./releases/Eimi_dev$buildType_$version_name.apk
    fi
else
    if [[($buildType == "debug")]]; then
       flutter build apk --target-platform android-arm64 --$buildType -t lib/Eimi_prod_main.dart --build-name=$version_name --build-number=$version_code --no-tree-shake-icons
       cp ./build/app/outputs/apk/Eimi_prod/$buildType/app-Eimi_prod-$buildType.apk ./releases/debug/Eimi_prod$buildType_$version_name.apk
    else
        flutter build apk --target-platform android-arm64 --analyze-size --$buildType -t lib/Eimi_prod_main.dart --build-name=$version_name --build-number=$version_code --no-tree-shake-icons
        cp ./build/app/outputs/apk/Eimi_prod/$buildType/app-Eimi_prod-$buildType.apk ./releases/Eimi_prod$buildType_$version_name.apk
    fi
fi

#BEGINCOMMENT
#"./build_Eimi_apk.sh " 1st parameter d/r(debug/release) space 2nd parameter d for dev else prod for server
#ENDCOMMENT
