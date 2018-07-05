Pod::Spec.new do |s|
  s.name             = 'EasyTuple'
  s.version          = '1.1.2'
  s.summary          = 'Use tuple like other modern programming languages'

  s.description      = <<-DESC
Sometimes you may need to return multiple values other than just one. In these cases, you can use a pointer, like `NSError **`, or you can put them into an array or a dictionary, or straightforward, create a class for it. But you have another choice now, EasyTuple, it can group multiple values in a better way. 
                       DESC

  s.homepage         = 'https://github.com/meituan/EasyTuple'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'WilliamZang' => 'chengwei.zang.1985@gmail.com' }
  s.source           = { :git => 'https://github.com/meituan/EasyTuple.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.8'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'EasyTuple/**/*.{m,h}'

  s.public_header_files = 'EasyTuple/**/*.h'
  
  s.module_map = 'EasyTuple/EasyTuple.modulemap'
  
  s.frameworks = 'Foundation'
end
