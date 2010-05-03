$:.unshift File.dirname(__FILE__) + "/../lib"

require 'test/unit'
require 'flexgen/ecore/ecore'

# The following would also influence other tests...
#
#module FlexGen::ECore
#  class EGenericType < EObject
#    contains_many_uni 'eTypeArguments', EGenericType
#  end
#  class ETypeParameter < ENamedElement
#  end
#  class EClassifier
#    contains_many_uni 'eTypeParameters', ETypeParameter
#  end
#  class ETypedElement
#    has_one 'eGenericType', EGenericType
#  end
#end
#
#FlexGen::ECore::ECoreInstantiator.clear_ecore_cache
#FlexGen::ECore::EString.ePackage = FlexGen::ECore.ecore

require 'flexgen/environment'
require 'flexgen/model_builder/model_serializer'
require 'flexgen/instantiator/ecore_xml_instantiator'
require 'flexgen/model_builder'

class ModelSerializerTest < Test::Unit::TestCase
  def test_ecore_internal
    File.open(File.dirname(__FILE__)+"/ecore_internal.rb","w") do |f|
      serializer = FlexGen::ModelBuilder::ModelSerializer.new(f, FlexGen::ECore.ecore)
      serializer.serialize(FlexGen::ECore.ecore)
    end
  end
  
  def xxx_test_ecore_original
    env = FlexGen::Environment.new
    File.open(File.dirname(__FILE__)+"/Ecore.ecore") { |f|
      ECoreXMLInstantiator.new(env,ECoreXMLInstantiator::ERROR).instantiate(f.read)
    }
    serializeEcore(env, "ecore", File.dirname(__FILE__)+"/ecore_original.rb")
    b = nil
    env2 = FlexGen::Environment.new
    FlexGen::ModelBuilder.build(FlexGen::ECore, env2) do
      b = binding
    end
    File.open(File.dirname(__FILE__)+"/ecore_original.rb") do |f|
      eval(f.read, b)
    end
    serializeEcore(env2, "ecore", File.dirname(__FILE__)+"/ecore_original_regenerated.rb")    
  end
  
  def serializeEcore(env, rootPackageName, fileName)
    env.find(:class => FlexGen::ECore::EClass).each {|c| c.eOperations = []}
    env.find(:class => FlexGen::ECore::EModelElement).each {|e| e.eAnnotations = []}
    File.open(fileName,"w") do |f|
      serializer = FlexGen::ModelBuilder::ModelSerializer.new(f, FlexGen::ECore.ecore)
      serializer.serialize(env.find(:class => FlexGen::ECore::EPackage, :name => rootPackageName))
    end
  end
end