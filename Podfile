# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
flutter_application_path = '../scanner_detail'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target 'ScannerApp' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ScannerApp
  install_all_flutter_pods(flutter_application_path)

  target 'ScannerAppTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ScannerAppUITests' do
  end

end

post_install do |installer|
  flutter_post_install(installer) if defined?(flutter_post_install)
end