Pod::Spec.new do |s|
  s.name             = 'Slauth'
  s.version          = '0.4.7'
  s.summary          = 'A Swift wrapper aroud Slauth Rust crate'
  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/Devolutions/SlauthPods.git'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'richerarc' => 'richer.arc@gmail.com' }
  s.source           = { :git => 'https://github.com/Devolutions/SlauthPods.git', :tag => s.version.to_s }

	s.swift_version = '5.0'
	s.ios.deployment_target = '11.0'
	
	s.source_files = 'Slauth/Classes/**/*', 'Slauth/Headers/*.h'
	s.vendored_libraries = 'Slauth/Rust/*.a'
end
