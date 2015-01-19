#!/usr/bin/env bash

rootDir="$(dirname $0)/.."
sassFile="${rootDir}/src/cache-warmer.sass"
cssFile="${rootDir}/src/cache-warmer.css"

sass --unix-newlines --sourcemap=none "${sassFile}" "${cssFile}"

jade --pretty "${rootDir}/src"

if test -f "${cssFile}"; then
    rm "${cssFile}"
fi

mv "${rootDir}/src/cache-warmer.html" "${rootDir}/foreplay-cache-warmer.html"
