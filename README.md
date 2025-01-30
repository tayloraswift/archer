[![ci build status](https://github.com/tayloraswift/archer/actions/workflows/Tests.yml/badge.svg)](https://github.com/tayloraswift/archer/actions/workflows/Tests.yml/badge.svg)
[![ci build status](https://github.com/tayloraswift/archer/actions/workflows/Deploy.yml/badge.svg)](https://github.com/tayloraswift/archer/actions/workflows/Deploy.yml/badge.svg)

# archer

A very minimal tool for packaging Swift WebAssembly products. [Forked](https://github.com/swiftwasm/carton/blob/1.1.3/LICENSE) from [Carton](https://github.com/swiftwasm/carton).

Unlike the original Carton, the central idea of Archer is to only do things that are not better handled by other tools. Archer emphasizes transparency, user-friendliness, and ease of integration into existing projects.

1. [Getting Started with WebAssembly](#getting-started-with-webassembly)
2. [`archer init`](#archer-init)
3. [`archer crush`](#archer-crush)


## Requirements

Archer supports Linux and macOS. We provide prebuilt binaries for several platforms.

| Platform | Architecture | Download |
| -------- | ------------ | -------- |
| macOS 15 | arm64 | [tar.gz](https://download.swiftinit.org/archer/0.1.0/macOS-ARM64/archer.tar.gz) |
| Ubuntu 24.04 | arm64 | [tar.gz](https://download.swiftinit.org/archer/0.1.0/Ubuntu-24.04-ARM64/archer.tar.gz) |
| Ubuntu 24.04 | x86_64 | [tar.gz](https://download.swiftinit.org/archer/0.1.0/Ubuntu-24.04-X64/archer.tar.gz) |
| Ubuntu 22.04 | arm64 | [tar.gz](https://download.swiftinit.org/archer/0.1.0/Ubuntu-22.04-ARM64/archer.tar.gz) |
| Ubuntu 22.04 | x86_64 | [tar.gz](https://download.swiftinit.org/archer/0.1.0/Ubuntu-22.04-X64/archer.tar.gz) |


Download the correct binary for your platform from the table above, extract it, and add the `archer` binary to your `PATH`. The pre-built Linux binaries do not require the Swift runtime to be installed on the system.


### ESBuild and Binaryen

We recommend installing the [`esbuild`](https://esbuild.github.io/) and [`binaryen`](https://github.com/WebAssembly/binaryen) tools on your system.

```bash
# Linux
sudo apt install esbuild binaryen
# macOS
brew install esbuild binaryen
```

ESBuild is a popular TypeScript/JavaScript compiler, and must be installed in order to build the frontend of a WebAssembly project.

Binaryen is a WebAssembly optimizer, which is optional but recommended for use with Archer, as it significantly reduces the size of the final WebAssembly binary.


## Getting Started with WebAssembly

These steps are not specific to Archer, this section is a general guide to compiling WebAssembly from Swift.

### Install the Swift WebAssembly SDK

If you have not done so already, install the Swift WebAssembly SDK:

```bash
swift sdk install \
    https://github.com/swiftwasm/swift/releases/download/swift-wasm-6.0.2-RELEASE/swift-wasm-6.0.2-RELEASE-wasm32-unknown-wasi.artifactbundle.zip \
    --checksum 6ffedb055cb9956395d9f435d03d53ebe9f6a8d45106b979d1b7f53358e1dcb4
```

>   Important:
>   On macOS, you must use one of the [downloadable toolchains from swift.org](https://www.swift.org/install/macos/). **The default Xcode toolchain does not support WebAssembly.** You can (temporarily) point the `swift` command to the downloaded toolchain by running `export TOOLCHAINS=$(plutil -extract CFBundleIdentifier raw /Library/Developer/Toolchains/$TOOLCHAIN_NAME.xctoolchain/Info.plist)`, where `TOOLCHAIN_NAME` is a string such as `swift-6.0.3-RELEASE`.

### Set up a SwiftPM Project

Below is a trivial SwiftPM template you can use to get started with WebAssembly.

```
📂 Sources
  - 📂 Hello
      - 🕊️ Hello.swift
🕊️ Package.swift
```

---
[`Package.swift`](Examples/Hello/Package.swift)

```swift
// swift-tools-version:6.0
import PackageDescription

let package:Package = .init(name: "WebAssembly Example",
    products: [
        .executable(name: "Hello", targets: ["Hello"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swiftwasm/JavaScriptKit", from: "0.21.0"),
    ],
    targets: [
        .executableTarget(name: "Hello",
            dependencies: [
                .product(name: "JavaScriptKit", package: "JavaScriptKit"),
            ]),
    ])
```

---
[`Hello.swift`](Examples/Hello/Sources/Hello/Hello.swift)

```swift
import JavaScriptKit

guard
case .object(let div) = JSObject.global.document.createElement("div")
else
{
    fatalError("Could not create elements")
}

div.innerHTML = .string("Hi Barbie!")

_ = JSObject.global.document.body.appendChild(div)
```

### Build the Project

Use the command below to build the project, replacing `SWIFTWASM_SDK` as needed.

```bash
SWIFTWASM_SDK=swift-wasm-6.0.2-RELEASE

swift build -c release \
    --product Hello \
    --swift-sdk $SWIFTWASM_SDK \
    -Xswiftc -Xclang-linker -Xswiftc -mexec-model=reactor \
    -Xlinker --export=__main_argc_argv
```

Yes, all of the trailing build flags are necessary.


## `archer init`

```text
USAGE: archer init [--wasm-path <wasm-path>] [--js-name <js-name>] [--js-runtime <js-runtime>] --bundle <bundle>

OPTIONS:
  -w, --wasm-path <wasm-path>
                          Where the browser should load the WebAssembly (wasm) binary from (default: main.wasm)
  -m, --js-name <js-name> What to name the generated JavaScript file (default: main.js)
  -J, --js-runtime <js-runtime>
                          Where to find the JavaScriptKit runtime (default:
                          .build/release/JavaScriptKit_JavaScriptKit.resources)
  -o, --bundle <bundle>   Where to write the generated resources to
  -h, --help              Show help information.
```


A WebAssembly bundle consists of the resources which will be deployed to the cloud and served to clients. The `archer init` command will build a minified JavaScript runtime for you and write it to a directory of your choice.

```bash
RUNTIME_NAME="runtime.js"
WASM_NAME="main.wasm"

archer init -m $RUNTIME_NAME -w $WASM_NAME -o Bundle
```

You need to provide the expected URL for the WebAssembly binary (`main.wasm`) and a path to a version of the JavaScriptKit runtime matching the version of JavaScriptKit you are using to build the WebAssembly.

There is no requirement to have built the project at this stage, but the easiest way to obtain the correct version of the runtime is to simply build the project (in `release` mode) with SwiftPM.

You probably also want to generate an HTML stub for previewing the WebAssembly, although in a larger project you would likely get this from elsewhere.

```bash
(
cat <<EOF
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>WebAssembly Example</title>
<script type="module" src="$RUNTIME_NAME"></script></head>
<body>
    <h1>WebAssembly Example</h1>
</body>
</html>
EOF
) > Bundle/index.html
```


## `archer crush`

```text
USAGE: archer crush [<wasm-file>] [--output <output>] [--Xwasm-opt <Xwasm-opt> ...] [--preserve-debug-info]

ARGUMENTS:
  <wasm-file>             Where to find the WebAssembly (wasm) binary to crush

OPTIONS:
  -o, --output <output>   Where to write the optimized WebAssembly (wasm) binary (default: main.wasm)
  --Xwasm-opt <Xwasm-opt> Extra flags to pass to the WebAssembly optimizer
  -g, --preserve-debug-info
                          Whether to preserve debug info or not
  -h, --help              Show help information.
```

The `archer crush` command is used to optimize a WebAssembly binary. The raw `.wasm` output of the Swift compiler will work out-of-the-box, but `archer crush` can make it much smaller and faster.

```bash
archer crush .build/release/Hello.wasm -o Bundle/$WASM_NAME
```

Once you have added the WebAssembly file to your bundle, you can use `esbuild` to preview it in a browser.

```bash
esbuild --servedir=Bundle
```

## License

Archer is Apache 2.0 licensed.
