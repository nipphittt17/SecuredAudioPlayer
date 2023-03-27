//
//  Generated file. Do not edit.
//

import FlutterMacOS
import Foundation

import audio_session
import desktop_multi_window
import device_info_plus
import just_audio
import macos_ui
import path_provider_foundation

func RegisterGeneratedPlugins(registry: FlutterPluginRegistry) {
  AudioSessionPlugin.register(with: registry.registrar(forPlugin: "AudioSessionPlugin"))
  FlutterMultiWindowPlugin.register(with: registry.registrar(forPlugin: "FlutterMultiWindowPlugin"))
  DeviceInfoPlusMacosPlugin.register(with: registry.registrar(forPlugin: "DeviceInfoPlusMacosPlugin"))
  JustAudioPlugin.register(with: registry.registrar(forPlugin: "JustAudioPlugin"))
  MacOSUiPlugin.register(with: registry.registrar(forPlugin: "MacOSUiPlugin"))
  PathProviderPlugin.register(with: registry.registrar(forPlugin: "PathProviderPlugin"))
}
