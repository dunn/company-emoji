#!/usr/local/bin/gawk -f

BEGIN {
  FS="\n"
  level = ENVIRON["VERSION_SHIFT"]
}
{
  PKG_NAME=gensub("\\.el", "", "g", FILENAME)
  VERSION_STRING=PKG_NAME"-version";

  package_version = match($1, "^;; Version: [0-9]");
  if (package_version) {
    version = substr($1, 13);
    const_string = "(defconst "VERSION_STRING" \""version"\")"
    print ";; Version: "bump(version, level)
    # set package_version to false since we only want to enter this
    # section once
    package_version=0
  } else if ($1 != "" && $1 == const_string) {
    print "(defconst "VERSION_STRING" \""bump(version, level)"\")"
  } else {
    print $1;
  }
}

function bump (vs, level) {
  if (level == "major") {
    vs = (substr(vs, 0, 1) + 1) ".0.0";
  } else if (level == "minor") {
    vs = substr(vs, 0, 1) "." (substr(vs, 3, 1) + 1) ".0";
  } else if (level == "patch") {
    vs = substr(vs, 0, 4) (substr(vs, 5, 1) + 1)
  }
  return vs;
}
