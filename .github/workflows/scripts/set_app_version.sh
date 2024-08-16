#!/bin/bash

# store version and build number in github env



function set_app_version() {
    echo 'Setting app version'
    # TODO: verify where sh will run to update build number
    build_number=$(echo $(grep "^version:" pubspec.yaml | sed 's/.*+\(.*\)/\1/' | awk '{print $1 + 1}'))
    # version=$(echo "${github.event.release.tag_name}" | cut -d 'v' -f2)
    echo "APP_VERSION=$version"
    echo "BUILD_NUMBER=$build_number"
}

set_app_version
