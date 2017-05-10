#
# Be sure to run `pod lib lint VendRegisterExtension.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'VendRegisterExtension'
s.version          = '0.1.0'
s.summary          = 'A collection of helpers to make extensions for VendRegister'

s.description      = <<-DESC
The VendRegisterExtension pod is a set of helpers to enable third-parties to quickly and easily create
extensions for VendRegister.

Please contact api@vendhq.com for support.
DESC

s.homepage         = 'https://github.com/Vend/VendRegisterExtension'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = 'TomCarey'
s.source           = { :git => 'https://github.com/Vend/VendRegisterExtension.git', :tag => s.version.to_s }

s.ios.deployment_target = '8.0'

s.source_files = 'VendRegisterExtension/Classes/**/*'

s.dependency 'Decodable', '~> 0.5'
end
