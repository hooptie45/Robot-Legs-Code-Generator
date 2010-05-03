require 'metamodels/uml13_metamodel'
require 'mmgen/metamodel_generator'
require 'flexgen/transformer'
require 'flexgen/environment'
require 'flexgen/ecore/ecore'

include MMGen::MetamodelGenerator

class ECoreCopyTransformer < FlexGen::Transformer
  copy_all FlexGen::ECore
end

eaMMRoot = ECoreCopyTransformer.new.trans(UML13.ecore)

eaMMRoot.name = "UML13EA"
eaMMRoot.eClassifiers.find{|c| c.name == "ActivityGraph"}.name = "ActivityModel"
eaMMRoot.eClassifiers.find{|c| c.name == "Pseudostate"}.name = "PseudoState"

compositeState = eaMMRoot.eClassifiers.find{|c| c.name == "CompositeState"}
compositeState.eReferences.find{|r| r.name == "subvertex"}.name = "substate"

generalization = eaMMRoot.eClassifiers.find{|c| c.name == "Generalization"}
generalization.eReferences.find{|r| r.name == "parent"}.name = "supertype"
generalization.eReferences.find{|r| r.name == "child"}.name = "subtype"

assocEnd = eaMMRoot.eClassifiers.find{|c| c.name == "AssociationEnd"}
assocEnd.eAttributes.find{|r| r.name == "ordering"}.name = "isOrdered"
assocEnd.eAttributes.find{|r| r.name == "changeability"}.name = "changeable"
assocEnd.eAttributes.find{|r| r.name == "isOrdered"}.eType = FlexGen::ECore::EBoolean
assocEnd.eAttributes.find{|r| r.name == "changeable"}.eType.eLiterals.find{|l| l.name == "frozen"}.name = "none"
multRef = assocEnd.eStructuralFeatures.find{|f| f.name == "multiplicity"}
multRef.eType = nil
assocEnd.removeEStructuralFeatures(multRef)
assocEnd.addEStructuralFeatures(FlexGen::ECore::EAttribute.new(:name => "multiplicity", :eType => FlexGen::ECore::EString))

xmiIdProvider = FlexGen::ECore::EClass.new(:name => "XmiIdProvider", :ePackage => eaMMRoot)
eaMMRoot.eClassifiers.each do |c|
  if %w(Package Class Generalization Association AssociationEnd StateVertex).include?(c.name)
    c.addESuperTypes(xmiIdProvider)
  end
end

generateMetamodel(eaMMRoot, File.dirname(__FILE__)+"/uml13_ea_metamodel.rb")
