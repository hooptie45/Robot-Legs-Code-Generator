$:.unshift File.join(File.dirname(__FILE__),"..","lib")

require 'test/unit'
require 'flexgen/array_extensions'
require 'flexgen/model_comparator'
require 'mmgen/metamodel_generator'
require 'flexgen/instantiator/ecore_xml_instantiator'
require 'flexgen/serializer/xmi20_serializer'

class MetamodelGeneratorTest < Test::Unit::TestCase
  
  TEST_DIR = File.dirname(__FILE__)+"/metamodel_roundtrip_test"
  
  include MMGen::MetamodelGenerator
  include FlexGen::ModelComparator
  
  module Regenerated
    Inside = binding
  end
  
  def test_generator
    require TEST_DIR+"/TestModel.rb"
    outfile = TEST_DIR+"/TestModel_Regenerated.rb"		
    generateMetamodel(HouseMetamodel.ecore, outfile)
    
    File.open(outfile) do |f|
      eval(f.read, Regenerated::Inside)
    end
    
    assert modelEqual?(HouseMetamodel.ecore, Regenerated::HouseMetamodel.ecore, ["instanceClassName"])
  end
  
  module UMLRegenerated
    Inside = binding
  end
  
  def test_generate_from_ecore
    outfile = TEST_DIR+"/houseMetamodel_from_ecore.rb"

    env = FlexGen::Environment.new
    File.open(TEST_DIR+"/houseMetamodel.ecore") { |f|
      ECoreXMLInstantiator.new(env).instantiate(f.read)
    }
    rootpackage = env.find(:class => FlexGen::ECore::EPackage).first
    rootpackage.name = "HouseMetamodel"
    generateMetamodel(rootpackage, outfile)
    
    File.open(outfile) do |f|
      eval(f.read, UMLRegenerated::Inside, "test_eval", 0)
    end
  end
  
  def test_ecore_serializer
    require TEST_DIR+"/TestModel.rb"
    File.open(TEST_DIR+"/houseMetamodel_Regenerated.ecore","w") do |f|
	  	ser = FlexGen::Serializer::XMI20Serializer.new(f)
	  	ser.serialize(HouseMetamodel.ecore)
	 	end
  end
  
end