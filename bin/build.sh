#!/usr/bin/env bash

binDir="$(dirname $0)"

jade --pretty "${binDir}/../src"

mv "${binDir}/../src/cache-warmer.html" "${binDir}/../foreplay-cache-warmer.html"
