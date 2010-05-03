$:.unshift File.dirname(__FILE__) + "/.."

# flexgen
require 'transformers/ecore_to_uml13'
require 'ea_support/ea_support'
require 'flexgen/environment'

# example metamodel
begin
  # try version created from EA export first
  require 'uml_class/generated/statemachine_metamodel_regenerated'
rescue LoadError
  require 'metamodel/statemachine_metamodel'
end

# new empty model environment
envUML = FlexGen::Environment.new

# transform example metamodel ecore model into UML model
ECoreToUML13.new(nil, envUML).trans(StatemachineMetamodel.ecore)

# serialize UML model as XMI which can be imported into Enterprise Architect
EASupport.serializeUML13ToXMI11(envUML, 
  File.dirname(__FILE__) + "/generated/statemachine_metamodel_import.xml", 
  :keep_ids => true)
