require "json"
version = JSON.parse(File.read("package.json"))["version"]

Pod::Spec.new do |s|
  s.name         = "RNTabBarSnapshot"
  s.version      = version
  s.description  = "Create TabBar Snapshot for React Native application which uses React Native Navigation"
  s.homepage     = "https://github.com/marf/react-native-tabbar-snapshot"
  s.summary      = "React Native + TabBar Snapshot"
  s.license      = "MIT"
  s.author       = { "Marco Fontana" => "fontana.marco@hotmail.com" }
  s.ios.deployment_target = "7.0"
  s.tvos.deployment_target = "9.0"
  s.source       = { git: "https://github.com/marf/react-native-tabbar-snapshot.git", tag: "v" + s.version.to_s }
  s.source_files = "ios/**/*.{h,m}"
  s.requires_arc = true

  s.dependency "React"
end
