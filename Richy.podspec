Pod::Spec.new do |s|
  s.name = "Richy"
  s.version = "1.0.0"
  s.summary = "Richy SDK"
  s.homepage = "Development only yet"
  s.license = { :type => "MIT", :file => "LICENSE" }
  s.author = "Qutaibah"
  s.platform = :ios, "10.0"
  s.source_files = "Richy/**/*.{swift}"
  s.module_name = "Richy"
  s.source = { :path => "." }
  s.swift_version = "5.0"
  s.dependency "Kingfisher", "~> 4.7.0"
end
