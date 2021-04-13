# cronet.dart

Resource package for [cronet](https://chromium.googlesource.com/chromium/src/+/master/components/cronet/)

# Build cronet

Accoding to https://chromiumdash.appspot.com/releases, major verion of 86 is the best choice of recent stable releases

## Prepare environment

### Windows

https://chromium.googlesource.com/chromium/src/+/master/docs/windows_build_instructions.md

- Install `VS 2019` (Community)
- Install `Desktop Development with C++` Workload
  -  Check `C++ ATL for latest v142 build tools`
  -  Check `C++ MFC for latest v142 build tools`
- Set `vs2019` or `GYP_MSVS_OVERRIDE_PATH`
- Install `depot_tools`
- Install `python27`

### macOS

https://chromium.googlesource.com/chromium/src/+/master/docs/mac_build_instructions.md

- Install `Xcode 12.2`+
- Install `depot_tools`

#### iOS

https://chromium.googlesource.com/chromium/src/+/master/docs/ios/build_instructions.md

> iOS should only be built on macOS

- Install `Xcode 12.2`+
- Install `depot_tools`

### Linux

https://chromium.googlesource.com/chromium/src/+/master/docs/linux/build_instructions.md

- Install `depot_tools`

> After fetch code, run `./build/install-build-deps.sh`

#### Android

https://chromium.googlesource.com/chromium/src/+/master/docs/android_build_instructions.md

- Install `depot_tools`

> After fetch code, run `./build/install-build-deps-android.sh`

## Fetch code

### Windows

```sh
mkdir chromium && cd chromium
fetch --no-histroy --nohooks chromium
gclient runhooks # for the first time
cd src && git fetch --tags
git checkout -b stable86 86.0.4240.198
cd .. && gclient sync -D -f
```

### macOS

```sh
mkdir chromium && cd chromium
fetch --no-histroy --nohooks chromium
gclient runhooks # for the first time
cd src && git fetch --tags
git checkout -b stable86 86.0.4240.198
cd .. && gclient sync -D -f
```

#### iOS

```sh
mkdir chromium-ios && cd chromium-ios
fetch --no-histroy --nohooks ios
gclient runhooks # for the first time
cd src && git fetch --tags
git checkout -b stable86 86.0.4240.93
cd .. && gclient sync -D -f
```

### Linux

```sh
mkdir chromium && cd chromium
fetch --no-histroy --nohooks chromium
cd src && ./build/install-build-deps.sh # for the first time
gclient runhooks # for the first time
cd src && git fetch --tags
git checkout -b stable86 86.0.4240.198
cd .. && gclient sync -D -f
```

#### Android 

```sh
mkdir chromium-android && cd chromium-android
fetch --no-histroy --nohooks android
cd src && ./build/install-build-deps-android.sh # for the first time
gclient runhooks # for the first time
cd src && git fetch --tags
git checkout -b stable86 86.0.4240.198
cd .. && gclient sync -D -f
```

## Setting up and build

### Windows

Default `target_cpu` is x64

```sh
cd src
gn args out\stable86_Release_Single_Cronet
# Add & save below lines
#  is_debug = false
#  is_component_build =false
ninja -C out\stable86_Release_Single_Cronet cronet_package
# out\stable86_Release_Single_Cronet\cronet\cronet.86.0.4240.198.dll
gn args out\stable86_Release_Single_Cronet --list --short --overridesonly > stable86_Release_Single_Cronet.overrides.log
```

### macOS

Default `target_cpu` is x64

```sh
cd src
gn args out/stable86_Release_Single_Cronet
# Add & save below lines
#  is_debug = false
#  is_component_build =false
ninja -C out/stable86_Release_Single_Cronet cronet_package
# out/stable86_Release_Single_Cronet/cronet/libcronet.86.0.4240.198.dylib
gn args out/stable86_Release_Single_Cronet --list --short --overridesonly > stable86_Release_Single_Cronet.overrides.log
```

#### iOS

Default `target_cpu` is x64

```sh
cd src
gn args out/stable86_Release_Cronet
# Add & save below lines
#  is_debug = false
#  is_component_build =false
ninja -C out/stable86_Release_Cronet cronet_package
# out/stable86_Release_Cronet/cronet/Static/Cronet.framework
gn args out/stable86_Release_Cronet --list --short --overridesonly > stable86_Release_Cronet.overrides.log
```

> When `gn args out/stable86_Release_Cronet_arm64`, add `target_cpu = "arm64"`, to generate arm64 for **iphoneos** instead of **iphonesimulator**

### Linux

Default `target_cpu` is x64

```sh
cd src
gn args out/stable86_Release_Single_Cronet
# Add & save below lines
#  is_debug = false
#  is_component_build =false
ninja -C out/stable86_Release_Single_Cronet cronet_package
# out/stable86_Release_Single_Cronet/cronet/libcronet.86.0.4240.198.so
gn args out/stable86_Release_Single_Cronet --list --short --overridesonly > stable86_Release_Single_Cronet.overrides.log
```

#### Android

Default `target_cpu` is arm

```sh
cd src
gn args out/stable86_Release_Cronet
# Add & save below lines
#  is_debug = false
#  is_component_build =false
ninja -C out/stable86_Release_Cronet cronet_package
# out/stable86_Release_Cronet/cronet/libs/armabi-v7a/libcronet.86.0.4240.198.so
gn args out/stable86_Release_Cronet --list --short --overridesonly > stable86_Release_Cronet.overrides.log
```

> When `gn args out/stable86_Release_Cronet_arm64`, add `target_cpu = "arm64"`, to generate `out/stable86_Release_Cronet/cronet/libs/arm64-v8a/libcronet.86.0.4240.198.so`

> When `gn args out/stable86_Release_Cronet_x86`, add `target_cpu = "x86"` and remove `arm_use_neon = false`, to generate `out/stable86_Release_Cronet/cronet/libs/x86/libcronet.86.0.4240.198.so`

> When `gn args out/stable86_Release_Cronet_x64`, add `target_cpu = "x64"` and remove `arm_use_neon = false`, to generate `out/stable86_Release_Cronet/cronet/libs/x86_64/libcronet.86.0.4240.198.so`
