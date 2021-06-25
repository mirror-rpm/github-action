#!/bin/bash

USER="${1}"
TOKEN="${2}"

map="_rpm_src.txt"

git=$( command -v git )
curl=$( command -v curl )

${curl} -o "${map}" 'https://raw.githubusercontent.com/mirror-rpm/github-action/main/_rpm_src.txt'
mapfile -t rpm_src < "${map}"

mirror() {
  for i in "${rpm_src[@]}"; do
    SOURCE="https://src.fedoraproject.org/rpms/${i}.git"
    TARGET="https://${USER}:${TOKEN}@github.com/mirror-rpm/${i}.git"

    mkdir -p "/root/git" && cd "/root/git" || exit 1

    ${git} clone --mirror "${SOURCE}" "${i}" && cd "${i}" || exit 1
    ${git} remote add 'target' "${TARGET}"  \
      && ${git} push 'target'               \
    cd ..
  done
}

mirror

exit 0
