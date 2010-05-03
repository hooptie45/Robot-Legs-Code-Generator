require 'flexgen/ecore/ecore_instantiator'
require 'flexgen/metamodel_builder/intermediate/annotation'

module FlexGen

module MetamodelBuilder

# This module is used to extend modules which should be
# part of FlexGen metamodels
module ModuleExtension
  include FlexGen::ECore::ECoreInstantiator
  
  def annotation(hash)
    _annotations << Intermediate::Annotation.new(hash)
  end
  
  def _annotations
    @_annotations ||= []
  end
  
  def final_method(m)
    @final_methods ||= []
    @final_methods << m
  end
  
  def method_added(m)
    raise "Method #{m} can not be redefined" if @final_methods && @final_methods.include?(m)
  end
end

end

end