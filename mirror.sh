#!/bin/bash

USER="${1}"
TOKEN="${2}"

map="_rpm_src.txt"

git=$( command -v git )

mapfile -t rpm_src < "${map}"

mirror() {
  for i in "${rpm_src[@]}"; do
    SOURCE="https://src.fedoraproject.org/rpms/${i}.git"
    TARGET="https://${USER}:${TOKEN}@https://github.com/mirror-rpm/${i}.git"

    ${git} clone --mirror "${SOURCE}" "/root/git/${i}" && pushd "/root/git/${i}" || exit 1
    ${git} remote add 'target' "${TARGET}"  \
      && ${git} push -f --mirror 'target'   \
    popd || exit 1
  done
}

mirror

exit 0
