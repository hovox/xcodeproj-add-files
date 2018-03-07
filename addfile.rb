require 'xcodeproj'

project_path = File.expand_path("./projex.xcodeproj")
project = Xcodeproj::Project.open(project_path)
file_ref = nil
project.targets.each do |target|
  puts target.name
  if target.name == "projex"
    target.resources_build_phase.files.each do |pbx_build_file|
      if pbx_build_file.file_ref.real_path.to_s.end_with?("img.jpg")
        file_ref = pbx_build_file.file_ref
      end
    end
  end
end

project.targets.each do |target|
  target.add_resources([file_ref])
end

project.save()
