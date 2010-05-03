# flexgen
require 'ea_support/ea_support'
require 'transformers/uml13_to_ecore'
require 'mmgen/metamodel_generator'
require 'flexgen/environment'
require 'flexgen/model_builder/model_serializer'

# make method "generateMetamodel" available on toplevel context
include MMGen::MetamodelGenerator

# read XMI export from Enterprise Architect as UML model
envUML = FlexGen::Environment.new
EASupport.instantiateUML13FromXMI11(envUML, File.dirname(__FILE__)+"/statemachine_metamodel_export.xml", :clean_model => true)

# transform UML model into ECore model
envECore = FlexGen::Environment.new
UML13ToECore.new(envUML, envECore).transform

# find the root package
root = envECore.find(:class => FlexGen::ECore::EPackage, :name => "StatemachineMetamodel").first
# use FlexGen metamodel generator to create the FlexGen Metamodel DSL representation
generateMetamodel(root, File.dirname(__FILE__)+"/generated/statemachine_metamodel_regenerated.rb")
