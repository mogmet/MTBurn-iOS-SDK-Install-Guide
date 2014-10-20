Pod::Spec.new do |s|
  s.name         = "AppDavis-iOS-SDK"
  s.version      = "1.0.10"
  s.summary      = "AppDavis SDK for iOS"
  s.homepage     = "https://github.com/mtburn/MTBurn-iOS-SDK-Install-Guide"
  s.license      = {
    :type => 'Commercial',
    :text => <<-LICENSE
      (C) M.T.Burn ALL RIGHTS RESERVED.
    LICENSE
  }
  s.author       = "M.T.Burn"

  s.platform     = :ios
  s.source = {
      :git => "https://github.com/mtburn/MTBurn-iOS-SDK-Install-Guide.git",
      :tag => "v1.0.10"
  }
  s.vendored_frameworks = 'AppDavis.framework'

  s.frameworks = 'StoreKit'
  s.compiler_flags = '-ObjC'
  s.requires_arc = true

  s.documentation = { :appledoc => [
      '--product-name', s.name,
      '--project-version', s.version,
      '--project-company', 'MTBurn']}
end
