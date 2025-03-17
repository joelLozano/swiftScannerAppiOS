//
//  ScannerAppApp.swift
//  ScannerApp
//
//  Created by Joel Lozano on 14/03/25.
//

import SwiftUI
import SwiftData
import Flutter


@Observable
class AppDelegate: FlutterAppDelegate {
  let flutterEngine = FlutterEngine(name: "my flutter engine")

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
      // Runs the default Dart entrypoint with a default Flutter route.
      flutterEngine.run();
      // Used to connect plugins (only if you have plugins with iOS platform code).
      GeneratedPluginRegistrant.register(with: self.flutterEngine);
      return true;
    }
}


@main
struct ScannerAppApp: App {
    
    init() {
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.backgroundColor = UIColor.purple
        }
    }
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            User.self,
            QRModel.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @State var flutterDependencies = FlutterDependencies()
    var body: some Scene {
        WindowGroup {
            LoginView()
                .environment(flutterDependencies)
        }
        .modelContainer(sharedModelContainer)
    }
}
