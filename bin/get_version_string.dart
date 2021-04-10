import 'dart:ffi';

import 'dart:io';

import 'package:cronet/cronet.dart';
import 'package:ffi/ffi.dart';

final DynamicLibrary Function() loadLibrary = () {
  if (Platform.isWindows) {
    return DynamicLibrary.open('${Directory.current.path}/cronet/windows/cronet.86.0.4240.198.dll');
  } else if (Platform.isMacOS) {
    return DynamicLibrary.open('${Directory.current.path}/cronet/macos/libcronet.86.0.4240.198.dylib');
  } else if (Platform.isLinux) {
    return DynamicLibrary.open('${Directory.current.path}/cronet/linux/libcronet.86.0.4240.198.so');
  }
  throw UnimplementedError();
};

final _croNet = CroNet(loadLibrary());

void main(List<String> arguments) {
  var enginePtr = _croNet.Cronet_Engine_Create();
  var engineParamsPtr = _croNet.Cronet_EngineParams_Create();

  try {
    _croNet.Cronet_Engine_StartWithParams(enginePtr, engineParamsPtr);

    var version = _croNet.Cronet_Engine_GetVersionString(enginePtr).cast<Utf8>().toDartString();
    print('Cronet version: $version');

    // Shutdown unless no long needed
    _croNet.Cronet_Engine_Shutdown(enginePtr);
  } finally {
    _croNet.Cronet_EngineParams_Destroy(engineParamsPtr);
    _croNet.Cronet_Engine_Destroy(enginePtr);
  }
}
