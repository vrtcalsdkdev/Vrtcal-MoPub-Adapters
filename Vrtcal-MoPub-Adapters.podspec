Pod::Spec.new do |s|
    s.name         = "Vrtcal-MoPub-Adapters"
    s.version      = "1.0.1"
    s.summary      = "Allows mediation with Vrtcal as either the primary or secondary SDK"
    s.homepage     = "http://vrtcal.com"
    s.license = { :type => 'Copyright', :text => <<-LICENSE
                   Copyright 2020 Vrtcal Markets, Inc.
                  LICENSE
                }
    s.author       = { "Scott McCoy" => "scott.mccoy@vrtcal.com" }
    s.source       = { :git => "https://github.vrtcal.com/scott/Vrtcal-MoPub-Adapters.git", :tag => "1.0.1" }
    s.source_files = "*.{h,m}"
    s.platform = :ios
    s.ios.deployment_target  = '11.0'

    s.dependency 'mopub-ios-sdk'
    s.dependency 'VrtcalSDK'
end
