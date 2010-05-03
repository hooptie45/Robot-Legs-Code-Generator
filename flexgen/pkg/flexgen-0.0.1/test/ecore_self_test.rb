$:.unshift File.join(File.dirname(__FILE__),"..","lib")

require 'test/unit'
require 'flexgen/ecore/ecore'
require 'flexgen/array_extensions'

class ECoreSelfTest < Test::Unit::TestCase
	include FlexGen::ECore
	
	def test_simple
		assert_equal \
			%w(lowerBound ordered unique upperBound many required eType).sort,
			ETypedElement.ecore.eStructuralFeatures.name.sort
			
		assert_equal \
			EClassifier.ecore,
			ETypedElement.ecore.eStructuralFeatures.find{|f| f.name=="eType"}.eType
		assert_equal %w(ENamedElement),	ETypedElement.ecore.eSuperTypes.name

		assert_equal \
			EModelElement.ecore,
			EModelElement.ecore.eStructuralFeatures.find{|f| f.name=="eAnnotations"}.eOpposite.eType

		assert_equal \
			%w(eType),
			ETypedElement.ecore.eReferences.name
			
		assert_equal \
			%w(lowerBound ordered unique upperBound many required).sort,
			ETypedElement.ecore.eAttributes.name.sort
			
		assert FlexGen::ECore.ecore.is_a?(EPackage)
		assert_equal "ECore", FlexGen::ECore.ecore.name
		assert_equal "FlexGen", FlexGen::ECore.ecore.eSuperPackage.name
		assert_equal %w(ECore), FlexGen.ecore.eSubpackages.name
		assert_equal\
			%w(EObject EModelElement EAnnotation ENamedElement ETypedElement 
				EStructuralFeature EAttribute EClassifier EDataType EEnum EEnumLiteral EFactory
				EOperation EPackage EParameter EReference EStringToStringMapEntry EClass).sort,
			FlexGen::ECore.ecore.eClassifiers.name.sort
			
        assert_equal "false", EAttribute.ecore.eAllAttributes.
          find{|a|a.name == "derived"}.defaultValueLiteral
        assert_equal false, EAttribute.ecore.eAllAttributes.
          find{|a|a.name == "derived"}.defaultValue

        assert_nil EAttribute.ecore.eAllAttributes.
          find{|a|a.name == "defaultValueLiteral"}.defaultValueLiteral
        assert_nil EAttribute.ecore.eAllAttributes.
          find{|a|a.name == "defaultValueLiteral"}.defaultValue

	end
end