//
//  FlutterEngine.swift
//  ScannerApp
//
//  Created by Joel Lozano on 17/03/25.
//

import SwiftUI
import Flutter
import FlutterPluginRegistrant

@Observable
class FlutterDependencies {
 let flutterEngine = FlutterEngine(name: "ScannerFlutterEngine")
 init() {
   flutterEngine.run()
   GeneratedPluginRegistrant.register(with: self.flutterEngine);
 }
}
