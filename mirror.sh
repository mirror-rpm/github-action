#!/bin/bash

USER="${1}"
TOKEN="${2}"

map="_rpm_src.txt"

git="$( command -v git )"
curl="$( command -v curl )"

${curl} -o "${map}" 'https://raw.githubusercontent.com/mirror-rpm/github-action/main/_rpm_src.txt'
mapfile -t rpm_src < "${map}"

mirror() {
  for i in "${rpm_src[@]}"; do
    SOURCE="https://src.fedoraproject.org/rpms/${i}.git"
    TARGET="https://${USER}:${TOKEN}@github.com/mirror-rpm/${i}.git"

    ${git} clone --bare "${SOURCE}" "/root/git/${i}" \
      && pushd "/root/git/${i}" || exit 1
    ${git} remote add 'target' "${TARGET}" \
      && ${git} push 'target' \
      && popd || exit 1
  done
}

mirror

exit 0
