#!/bin/bash
# Created with package:mono_repo v2.3.0

# Support built in commands on windows out of the box.
function pub {
       if [[ $TRAVIS_OS_NAME == "windows" ]]; then
        command pub.bat "$@"
    else
        command pub "$@"
    fi
}
function dartfmt {
       if [[ $TRAVIS_OS_NAME == "windows" ]]; then
        command dartfmt.bat "$@"
    else
        command dartfmt "$@"
    fi
}
function dartanalyzer {
       if [[ $TRAVIS_OS_NAME == "windows" ]]; then
        command dartanalyzer.bat "$@"
    else
        command dartanalyzer "$@"
    fi
}

if [[ -z ${PKGS} ]]; then
  echo -e '\033[31mPKGS environment variable must be set!\033[0m'
  exit 1
fi

if [[ "$#" == "0" ]]; then
  echo -e '\033[31mAt least one task argument must be provided!\033[0m'
  exit 1
fi

EXIT_CODE=0

for PKG in ${PKGS}; do
  echo -e "\033[1mPKG: ${PKG}\033[22m"
  pushd "${PKG}" || exit $?

  PUB_EXIT_CODE=0
  pub get --no-precompile || PUB_EXIT_CODE=$?

  if [[ ${PUB_EXIT_CODE} -ne 0 ]]; then
    EXIT_CODE=1
    echo -e '\033[31mpub get failed\033[0m'
    popd
    continue
  fi

  for TASK in "$@"; do
    echo
    echo -e "\033[1mPKG: ${PKG}; TASK: ${TASK}\033[22m"
    case ${TASK} in
    command)
      echo './build.sh'
      ./build.sh || EXIT_CODE=$?
      ;;
    dartanalyzer_0)
      echo 'dartanalyzer --fatal-infos --fatal-warnings .'
      dartanalyzer --fatal-infos --fatal-warnings . || EXIT_CODE=$?
      ;;
    dartanalyzer_1)
      echo 'dartanalyzer --fatal-infos --fatal-warnings bin/ lib/'
      dartanalyzer --fatal-infos --fatal-warnings bin/ lib/ || EXIT_CODE=$?
      ;;
    dartfmt)
      echo 'dartfmt -n --set-exit-if-changed .'
      dartfmt -n --set-exit-if-changed . || EXIT_CODE=$?
      ;;
    test_0)
      echo 'pub run test --run-skipped'
      pub run test --run-skipped || EXIT_CODE=$?
      ;;
    test_1)
      echo 'pub run test --run-skipped --concurrency=1'
      pub run test --run-skipped --concurrency=1 || EXIT_CODE=$?
      ;;
    *)
      echo -e "\033[31mNot expecting TASK '${TASK}'. Error!\033[0m"
      EXIT_CODE=1
      ;;
    esac
  done

  popd
done

exit ${EXIT_CODE}
