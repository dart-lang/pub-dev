#!/bin/bash
# Created with package:mono_repo v3.4.2

# Support built in commands on windows out of the box.
function pub() {
  if [[ $TRAVIS_OS_NAME == "windows" ]]; then
    command pub.bat "$@"
  else
    command pub "$@"
  fi
}
function dartfmt() {
  if [[ $TRAVIS_OS_NAME == "windows" ]]; then
    command dartfmt.bat "$@"
  else
    command dartfmt "$@"
  fi
}
function dartanalyzer() {
  if [[ $TRAVIS_OS_NAME == "windows" ]]; then
    command dartanalyzer.bat "$@"
  else
    command dartanalyzer "$@"
  fi
}

if [[ -z ${PKGS} ]]; then
  echo -e '\033[31mPKGS environment variable must be set! - TERMINATING JOB\033[0m'
  exit 64
fi

if [[ "$#" == "0" ]]; then
  echo -e '\033[31mAt least one task argument must be provided! - TERMINATING JOB\033[0m'
  exit 64
fi

SUCCESS_COUNT=0
declare -a FAILURES

for PKG in ${PKGS}; do
  echo -e "\033[1mPKG: ${PKG}\033[22m"
  EXIT_CODE=0
  pushd "${PKG}" >/dev/null || EXIT_CODE=$?

  if [[ ${EXIT_CODE} -ne 0 ]]; then
    echo -e "\033[31mPKG: '${PKG}' does not exist - TERMINATING JOB\033[0m"
    exit 64
  fi

  pub get --no-precompile || EXIT_CODE=$?

  if [[ ${EXIT_CODE} -ne 0 ]]; then
    echo -e "\033[31mPKG: ${PKG}; 'pub get' - FAILED  (${EXIT_CODE})\033[0m"
    FAILURES+=("${PKG}; 'pub get'")
  else
    for TASK in "$@"; do
      EXIT_CODE=0
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
      test_00)
        echo 'pub run test --run-skipped `find test -name "*_test\\.dart" | sort | sed -n '0~7p'`'
        pub run test --run-skipped `find test -name "*_test\\.dart" | sort | sed -n '0~7p'` || EXIT_CODE=$?
        ;;
      test_01)
        echo 'pub run test --run-skipped `find test -name "*_test\\.dart" | sort | sed -n '1~7p'`'
        pub run test --run-skipped `find test -name "*_test\\.dart" | sort | sed -n '1~7p'` || EXIT_CODE=$?
        ;;
      test_02)
        echo 'pub run test --run-skipped `find test -name "*_test\\.dart" | sort | sed -n '2~7p'`'
        pub run test --run-skipped `find test -name "*_test\\.dart" | sort | sed -n '2~7p'` || EXIT_CODE=$?
        ;;
      test_03)
        echo 'pub run test --run-skipped `find test -name "*_test\\.dart" | sort | sed -n '3~7p'`'
        pub run test --run-skipped `find test -name "*_test\\.dart" | sort | sed -n '3~7p'` || EXIT_CODE=$?
        ;;
      test_04)
        echo 'pub run test --run-skipped `find test -name "*_test\\.dart" | sort | sed -n '4~7p'`'
        pub run test --run-skipped `find test -name "*_test\\.dart" | sort | sed -n '4~7p'` || EXIT_CODE=$?
        ;;
      test_05)
        echo 'pub run test --run-skipped `find test -name "*_test\\.dart" | sort | sed -n '5~7p'`'
        pub run test --run-skipped `find test -name "*_test\\.dart" | sort | sed -n '5~7p'` || EXIT_CODE=$?
        ;;
      test_06)
        echo 'pub run test --run-skipped `find test -name "*_test\\.dart" | sort | sed -n '6~7p'`'
        pub run test --run-skipped `find test -name "*_test\\.dart" | sort | sed -n '6~7p'` || EXIT_CODE=$?
        ;;
      test_07)
        echo 'pub run test --run-skipped'
        pub run test --run-skipped || EXIT_CODE=$?
        ;;
      test_08)
        echo 'pub run test --run-skipped --concurrency=1 `find test -name "*_test\\.dart" | sort | sed -n '0~3p'`'
        pub run test --run-skipped --concurrency=1 `find test -name "*_test\\.dart" | sort | sed -n '0~3p'` || EXIT_CODE=$?
        ;;
      test_09)
        echo 'pub run test --run-skipped --concurrency=1 `find test -name "*_test\\.dart" | sort | sed -n '1~3p'`'
        pub run test --run-skipped --concurrency=1 `find test -name "*_test\\.dart" | sort | sed -n '1~3p'` || EXIT_CODE=$?
        ;;
      test_10)
        echo 'pub run test --run-skipped --concurrency=1 `find test -name "*_test\\.dart" | sort | sed -n '2~3p'`'
        pub run test --run-skipped --concurrency=1 `find test -name "*_test\\.dart" | sort | sed -n '2~3p'` || EXIT_CODE=$?
        ;;
      *)
        echo -e "\033[31mUnknown TASK '${TASK}' - TERMINATING JOB\033[0m"
        exit 64
        ;;
      esac

      if [[ ${EXIT_CODE} -ne 0 ]]; then
        echo -e "\033[31mPKG: ${PKG}; TASK: ${TASK} - FAILED (${EXIT_CODE})\033[0m"
        FAILURES+=("${PKG}; TASK: ${TASK}")
      else
        echo -e "\033[32mPKG: ${PKG}; TASK: ${TASK} - SUCCEEDED\033[0m"
        SUCCESS_COUNT=$((SUCCESS_COUNT + 1))
      fi

    done
  fi

  echo
  echo -e "\033[32mSUCCESS COUNT: ${SUCCESS_COUNT}\033[0m"

  if [ ${#FAILURES[@]} -ne 0 ]; then
    echo -e "\033[31mFAILURES: ${#FAILURES[@]}\033[0m"
    for i in "${FAILURES[@]}"; do
      echo -e "\033[31m  $i\033[0m"
    done
  fi

  popd >/dev/null || exit 70
  echo
done

if [ ${#FAILURES[@]} -ne 0 ]; then
  exit 1
fi
