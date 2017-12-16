#!/bin/bash
set -e

url=$1

installAppFromDmg () {
  url=$1
  tmpDmg="`mktemp`"
  tmpVol="`mktemp`"
  fetchFile $url $tmpDmg
  mountDmg $tmpDmg $tmpVol 
  installAppFromVol $tmpVol
  unmountDmg $tmpVol
  deleteDmg $tmpDmg
}

fetchFile () {
  url=$1
  file=$2
  echo "Downloading $url into $file..."
  curl -L -s -o "$file" "$url"
}

mountDmg () {
  dmg=$1
  vol=$2
  echo "Deleting $vol then mounting $dmg at $vol..."
  rm "$vol" # mktemp has created the file - we cant mount here until it's remove
  hdiutil mount "$dmg" -nobrowse -mountpoint "$vol"
}

installAppFromVol () (
  # nb: parens make this execute in a subshell
  dir=$1
  echo "Locating .app in $dir then copying it to /Applications..."
  shopt -s nullglob
  apps=($dir/*.app)
  if [ "${#apps[@]}" -eq "1" ]; then
    echo " - found .app at ${apps[1]}"
    cp -R "${apps[1]}" /Applications
  else 
    echo " - unable to find app :("
    echo "BAD"
  fi
)

unmountDmg () {
  vol=$1
  echo "Unmounting volume $vol..."
  hdiutil unmount $vol
}

deleteDmg () {
  dmg=$1
  echo "Removing dmg $dmg..."
  rm $dmg
}

installAppFromDmg $url

