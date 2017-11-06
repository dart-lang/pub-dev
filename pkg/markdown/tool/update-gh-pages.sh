# Echo every command being run.
set +x

# Fail fast if a command fails.
set -e

pub global activate peanut

peanut -d example

echo Now push updated gh-pages branch with:
echo
echo '    git push origin --set-upstream gh-pages'
