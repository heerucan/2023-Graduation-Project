#!/bin/sh

#  ci_pre_xcodebuild.sh
#  Kevin
#
#  Created by heerucan on 2023/05/21.
#  

echo "Stage: PRE-Xcode Build is activated .... "

# Move to the place where the scripts are located.
# This is important because the position of the subsequently mentioned files depend of this origin.
cd $CI_WORKSPACE/ci_scripts || exit 1

# Write a JSON File containing all the environment variables and secrets.
printf "{\"NAVER_KEY\":\"%s\",\"NAVER_KEY_ID\":\"%s\",\"CHAT_KEY\":\"%s\"}" "$NAVER_KEY" "$NAVER_KEY_ID" "$CHAT_KEY" >> ../Kevin/Kevin/Application/Secrets.json

echo "Wrote Secrets.json file."

echo "Stage: PRE-Xcode Build is DONE .... "

exit 0
