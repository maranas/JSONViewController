Pod::Spec.new do |s|
  s.name         = "JSONViewController"
  s.version      = "0.1.1"
  s.summary      = "JSON driven view controllers using Flexbox"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
                    JSONViewController is a way to define views and routing
                    using JSON and Flexbox (YogaKit). It is designed to work
                    with server-side JSON, but should work with bundled JSON
                    in the client as well.
                   DESC

  s.homepage     = "https://github.com/maranas/JSONViewController"
  s.screenshots  = "https://raw.githubusercontent.com/maranas/JSONViewController/master/samplefeed.gif"
  s.license      = "MIT (example)"
  s.license      = { :type => "MIT", :file => "LICENSE" }


  s.author             = { "Moises Aranas" => "moises@ganglionsoftware.com" }
  s.platform     = :ios, '9.0'
  s.source       = { :git => "https://github.com/maranas/JSONViewController.git", :tag => "0.1.1" }


  s.source_files  = "JSONViewController/**/*.{h,m}"
  s.framework  = "UIKit"
  s.dependency "YogaKit", "~> 1.7"

  s.swift_version = "4.2"

end
