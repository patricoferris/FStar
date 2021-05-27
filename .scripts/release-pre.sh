# This file is to be included at the beginning of release scripts, to
# determine the version tag, and create one if necessary


# Sorry, everyone
if (( ${BASH_VERSION%%.*} < 4 )); then
  echo "This script requires Bash >= 4. On OSX, try: brew install bash"
  exit 1
fi

# Any error is fatal.
set -e
set -o pipefail

set -x

git_org=tahina-pro
git_remote=tahina-pro

# Check if the user has provided a GitHub authentication token
[[ -n $SATS_TOKEN ]]

# Detect the F* directory and enter it
FSTAR_HOST_HOME=$(cd `dirname $0`/.. && pwd)
[[ -n $FSTAR_HOST_HOME ]]
pushd "$FSTAR_HOST_HOME"

# Make sure we are starting in the right place (F* repository)
if ! [[ -d ulib ]]; then
  echo "This script is intended to be run from the root of the F* repository"
  exit 1
fi

# Fail if the state is dirty
git diff --staged --exit-code
git diff --exit-code

# Detect the F* version number
git fetch --tags $git_org
if [[ -n $FSTAR_VERSION ]] ; then
    # It is provided by the user
    my_tag="$FSTAR_VERSION"
elif my_tag=$(git describe --tags --exact-match) ; then
    # It is the tag of the current commit
    # Check that there is only one tag
    [[ $(echo $my_tag | wc -w) -eq 1 ]]
else
    # Generate a new tag under the vYYYY.MM.DD format
    my_tag=$(date '+v%Y.%m.%d')
fi

# Check if the commit pointed to by that tag (if any) points to the current commit
this_commit=$(git rev-parse HEAD)
git_push_tag_cmd=true
if tagged_commit=$(git show-ref --tags --hash "$my_tag") && [[ -n $tagged_commit ]] ; then
    [[ $tagged_commit = $this_commit ]]
else
    # the tag does not exist, but check that it does not correspond to
    # an existing branch
    # so we can apply it
    # and we will need to push it before pushing the release
    if test_ref=$(git show-ref "$my_tag") ; then
        [[ -z "$test_ref" ]]
    fi
    git_push_tag_cmd="git push $git_remote $my_tag"
    git tag "$my_tag"
fi

# Overwrite the version number. We need to strip the initial v. Note:
# this version number will not be committed, because, if a user
# compiles from master, then they should have a dev version number,
# but the version number used at compilation time will be read from
# version.txt
CURRENT_VERSION=$(echo $my_tag | sed 's!^v!!')
echo $CURRENT_VERSION > version.txt

# Exit the F* directory
popd
