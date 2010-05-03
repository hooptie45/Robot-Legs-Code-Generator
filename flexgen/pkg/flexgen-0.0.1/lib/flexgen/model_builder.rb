require 'flexgen/model_builder/builder_context'
require 'flexgen/method_delegation'
require 'ruby-prof'

module FlexGen
  
module ModelBuilder

  def self.build(package, env=nil, builderMethodsModule=nil, &block)
    resolver = ReferenceResolver.new
    bc = BuilderContext.new(package, builderMethodsModule, resolver, env)
    contextModule = eval("Module.nesting", block.binding).first
    MethodDelegation.registerDelegate(bc, contextModule, "const_missing")
    RubyProf.start
    bc.instance_eval(&block)
    prof = RubyProf.stop
    File.open("profile_flat.txt","w+") do |f|
      RubyProf::FlatPrinter.new(prof).print(f, 0)
    end
    MethodDelegation.unregisterDelegate(bc, contextModule, "const_missing")
    puts "Resolving..."
    resolver.resolve(bc.toplevelElements)
    bc.toplevelElements
  end    
end

end