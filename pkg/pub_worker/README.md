# Pub Worker

`pkg/pub_worker` is a separate application from the main `pub-dev/app/` directory. It provides isolated execution for package analysis and runs in the environment defined in `Dockerfile.worker`.

## How it runs

During deployment, a `pub_worker` container image is built using `Dockerfile.worker`. The `pub.dev` main application tracks package analysis tasks and, when scheduling a task, launches a Google Cloud Compute instance with the built container image. The analysis instructions (which package to analyze) are passed as command-line arguments to the docker invocation via the cloud config that starts each individual instance.

The entry point, `bin/pub_worker.dart`, reads the payload, initiates the analysis, and uploads the results to the URLs specified in the payload.

The analysis process is `bin/pub_worker_subprocess.dart`, which:
- downloads the package,
- selects the appropriate SDK,
- initializes `pana` (in-process mode), and
- runs the analysis.

Some minor details:
- All output from `bin/pub_worker_subprocess.dart` is stored in `log.txt` and part of the uploaded blob.
- `pana` also invokes `bin/sandbox_runner.dart`, which creates and uses a gVisor sandbox for running subprocesses required for the analysis.
- Each application in the `bin/` directory is AOT-compiled when the container image is built.

## Configuration

The following environment variables are configured in `Dockerfile.worker` and are available to the applications:

### General configuration

| Variable               | Description                                                                    |
|------------------------|--------------------------------------------------------------------------------|
| `PUB_ENVIRONMENT`      | Identifies the runtime environment for tracking statistics.                    |
| `CI`                   | Set to `"true"` to indicate non-interactive processes.                         |
| `NO_COLOR`             | Set to `"true"` to disable colored terminal output.                            |
| `PATH`                 | Generic OS `PATH`, prepended with the Dart SDK’s `bin` and other dependencies. |

### SDK configuration

| Variable         | Description                                      |
|------------------|--------------------------------------------------|
| `DART_SDK`       | Path to the stable Dart SDK installation.        |
| `FLUTTER_ROOT`   | Path to the stable Flutter SDK installation.     |

### `pana` configuration

| Variable                       | Description                                                               |
|--------------------------------|---------------------------------------------------------------------------|
| `DARTDOC_BINARY`               | Path to the AOT-compiled `dartdoc` executable.                            |
| `DARTDOC_RESOURCES_DIR`        | Path to `dartdoc` resource files.                                         |
| `PANA_LICENSE_DATA_DIR`        | Path to SPDX license data used by `pana`.                                 |
| `PUB_WORKER_SUBPROCESS_BINARY` | Path to the AOT-compiled `pub_worker_subprocess` binary.                  |

### Sandbox configuration

| Variable               | Description                                                                 |
|------------------------|-----------------------------------------------------------------------------|
| `SANDBOX_ROOTFS`       | Path to the root filesystem for sandboxed execution.                        |
| `SANDBOX_RUNNER`       | Path to the AOT-compiled `sandbox_runner` binary.                           |

### Build Artifacts

*(Not directly used in `pub_worker`)*

| Variable               | Description                                                                 |
|------------------------|-----------------------------------------------------------------------------|
| `DARTDOC_DIR`          | Installation directory for `dartdoc`.                                       |
| `PUB_WORKER_BUILD_DIR` | Build output directory for `pub_worker` binaries.                           |


## `sandbox_runner` configuration

The `bin/sandbox_runner.dart` executable launches gVisor sandboxes for isolated subprocess execution. It uses the following environment variables:

### Sandbox control variables

| Variable                     | Description                                                                 |
|------------------------------|-----------------------------------------------------------------------------|
| `SANDBOX_NETWORK_ENABLED`    | Set to `"true"` to enable network access within the sandbox.                |
| `SANDBOX_OUTPUT`             | Colon-separated list of writable directory paths within the sandbox.        |
| `SANDBOX_DEBUG_LOG_DIR`      | Directory path for gVisor debug logs (optional, for local testing).         |

### Pass-Through Variables

*(Automatically forwarded from the host environment into the sandbox)*

- `CI`
- `NO_COLOR`
- `PATH`
- `HOME`
- `XDG_CONFIG_HOME`
- `FLUTTER_ROOT`
- `PUB_CACHE`
- `PUB_ENVIRONMENT`
- `PUB_HOSTED_URL`
