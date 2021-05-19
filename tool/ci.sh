#!/bin/bash
# Created with package:mono_repo v4.0.0

# Support built in commands on windows out of the box.
# When it is a flutter repo (check the pubspec.yaml for "sdk: flutter")
# then "flutter" is called instead of "pub".
# This assumes that the Flutter SDK has been installed in a previous step.
function pub() {
  if grep -Fq "sdk: flutter" "${PWD}/pubspec.yaml"; then
    if [[ $TRAVIS_OS_NAME == "windows" ]]; then
      command flutter.bat pub "$@"
    else
      command flutter pub "$@"
    fi
  else
    if [[ $TRAVIS_OS_NAME == "windows" ]]; then
      command pub.bat "$@"
    else
      command pub "$@"
    fi
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
      command_00)
        echo 'pub run test'
        pub run test || EXIT_CODE=$?
        ;;
      command_01)
        echo 'pub run test --test-randomize-ordering-seed=random'
        pub run test --test-randomize-ordering-seed=random || EXIT_CODE=$?
        ;;
      command_02)
        echo 'dartanalyzer --fatal-infos .'
        dartanalyzer --fatal-infos . || EXIT_CODE=$?
        ;;
      command_03)
        echo 'dartfmt --dry-run --set-exit-if-changed .'
        dartfmt --dry-run --set-exit-if-changed . || EXIT_CODE=$?
        ;;
      command_04)
        echo 'pub run test test/all_test.dart --platform vm'
        pub run test test/all_test.dart --platform vm || EXIT_CODE=$?
        ;;
      command_05)
        echo 'pub run test test/all_test.dart --platform chrome'
        pub run test test/all_test.dart --platform chrome || EXIT_CODE=$?
        ;;
      command_06)
        echo 'pub global activate dart_coveralls && dart_coveralls report test/all_test.dart'
        pub global activate dart_coveralls && dart_coveralls report test/all_test.dart || EXIT_CODE=$?
        ;;
      command_07)
        echo 'xvfb-run -s "-screen 0 1024x768x24" pub run test --preset travis -x phantomjs --total-shards 5 --shard-index 0'
        xvfb-run -s "-screen 0 1024x768x24" pub run test --preset travis -x phantomjs --total-shards 5 --shard-index 0 || EXIT_CODE=$?
        ;;
      command_08)
        echo 'xvfb-run -s "-screen 0 1024x768x24" pub run test --preset travis -x phantomjs --total-shards 5 --shard-index 1'
        xvfb-run -s "-screen 0 1024x768x24" pub run test --preset travis -x phantomjs --total-shards 5 --shard-index 1 || EXIT_CODE=$?
        ;;
      command_09)
        echo 'xvfb-run -s "-screen 0 1024x768x24" pub run test --preset travis -x phantomjs --total-shards 5 --shard-index 2'
        xvfb-run -s "-screen 0 1024x768x24" pub run test --preset travis -x phantomjs --total-shards 5 --shard-index 2 || EXIT_CODE=$?
        ;;
      command_10)
        echo 'xvfb-run -s "-screen 0 1024x768x24" pub run test --preset travis -x phantomjs --total-shards 5 --shard-index 3'
        xvfb-run -s "-screen 0 1024x768x24" pub run test --preset travis -x phantomjs --total-shards 5 --shard-index 3 || EXIT_CODE=$?
        ;;
      command_11)
        echo 'xvfb-run -s "-screen 0 1024x768x24" pub run test --preset travis -x phantomjs --total-shards 5 --shard-index 4'
        xvfb-run -s "-screen 0 1024x768x24" pub run test --preset travis -x phantomjs --total-shards 5 --shard-index 4 || EXIT_CODE=$?
        ;;
      command_12)
        echo 'pub run test --preset travis -x browser'
        pub run test --preset travis -x browser || EXIT_CODE=$?
        ;;
      command_13)
        echo './build.sh'
        ./build.sh || EXIT_CODE=$?
        ;;
      dartanalyzer_0)
        echo 'dartanalyzer --fatal-infos --fatal-warnings .'
        dartanalyzer --fatal-infos --fatal-warnings . || EXIT_CODE=$?
        ;;
      dartanalyzer_1)
        echo 'dartanalyzer --fatal-warnings .'
        dartanalyzer --fatal-warnings . || EXIT_CODE=$?
        ;;
      dartanalyzer_2)
        echo 'dartanalyzer --fatal-warnings --fatal-infos .'
        dartanalyzer --fatal-warnings --fatal-infos . || EXIT_CODE=$?
        ;;
      dartanalyzer_3)
        echo 'dartanalyzer .'
        dartanalyzer . || EXIT_CODE=$?
        ;;
      dartanalyzer_4)
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
      test_08)
        echo 'pub run test -x integration --test-randomize-ordering-seed=random'
        pub run test -x integration --test-randomize-ordering-seed=random || EXIT_CODE=$?
        ;;
      test_09)
        echo 'pub run test -t integration --total-shards 5 --shard-index 0 --test-randomize-ordering-seed=random'
        pub run test -t integration --total-shards 5 --shard-index 0 --test-randomize-ordering-seed=random || EXIT_CODE=$?
        ;;
      test_10)
        echo 'pub run test -t integration --total-shards 5 --shard-index 1 --test-randomize-ordering-seed=random'
        pub run test -t integration --total-shards 5 --shard-index 1 --test-randomize-ordering-seed=random || EXIT_CODE=$?
        ;;
      test_11)
        echo 'pub run test -t integration --total-shards 5 --shard-index 2 --test-randomize-ordering-seed=random'
        pub run test -t integration --total-shards 5 --shard-index 2 --test-randomize-ordering-seed=random || EXIT_CODE=$?
        ;;
      test_12)
        echo 'pub run test -t integration --total-shards 5 --shard-index 3 --test-randomize-ordering-seed=random'
        pub run test -t integration --total-shards 5 --shard-index 3 --test-randomize-ordering-seed=random || EXIT_CODE=$?
        ;;
      test_13)
        echo 'pub run test -t integration --total-shards 5 --shard-index 4 --test-randomize-ordering-seed=random'
        pub run test -t integration --total-shards 5 --shard-index 4 --test-randomize-ordering-seed=random || EXIT_CODE=$?
        ;;
      test_15)
        echo 'pub run test --run-skipped -t presubmit-only test/ensure_build_test.dart'
        pub run test --run-skipped -t presubmit-only test/ensure_build_test.dart || EXIT_CODE=$?
        ;;
      test_16)
        echo 'pub run test -p chrome'
        pub run test -p chrome || EXIT_CODE=$?
        ;;
      test_17)
        echo 'pub run test --run-skipped'
        pub run test --run-skipped || EXIT_CODE=$?
        ;;
      test_18)
        echo 'pub run test --run-skipped --concurrency=1 `find test -name "*_test\\.dart" | sort | sed -n '0~3p'`'
        pub run test --run-skipped --concurrency=1 `find test -name "*_test\\.dart" | sort | sed -n '0~3p'` || EXIT_CODE=$?
        ;;
      test_19)
        echo 'pub run test --run-skipped --concurrency=1 `find test -name "*_test\\.dart" | sort | sed -n '1~3p'`'
        pub run test --run-skipped --concurrency=1 `find test -name "*_test\\.dart" | sort | sed -n '1~3p'` || EXIT_CODE=$?
        ;;
      test_20)
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
