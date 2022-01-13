#!/bin/sh -xe
info()
{
    echo '[INFO] ' "$@"
}
fatal()
{
    echo '[ERROR] ' "$@" >&2
    exit 1
}
replace_manifest() {
  NEW_MANIFEST="/lhcp-lcm/manifests/metallb.yaml"
  FULL_MANIFEST_PATH="/var/lib/rancher/k3s/server/manifests"
  HOST_MANIFEST_PATH="/host$FULL_MANIFEST_PATH"
  mkdir -p $HOST_MANIFEST_PATH
  info "Deploying new k3s manifest to $FULL_MANIFEST_PATH"
  # sleep 1d
  cp $NEW_MANIFEST $HOST_MANIFEST_PATH
  info "K3s manifest has been placed successfully"
  return
}
verify_upgrade_versions() {
  echo "Lets do some verification"
}
upgrade() {
  replace_manifest
}
"$@"