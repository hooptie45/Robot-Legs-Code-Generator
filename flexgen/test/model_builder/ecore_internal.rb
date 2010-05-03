ePackage "ECore", :eSuperPackage => "" do
  eClass "EObject", :abstract => false, :interface => false, :eSubTypes => ["EAnnotation"], :instanceClassName => "FlexGen::ECore::EObject"
  eClass "EAttribute", :abstract => false, :interface => false, :eSuperTypes => ["EStructuralFeature"], :instanceClassName => "FlexGen::ECore::EAttribute" do
    eAttribute "iD", :defaultValueLiteral => "false", :eType => ""
    eReference "eAttributeType", :changeable => false, :derived => true, :transient => true, :volatile => true, :lowerBound => 1, :eType => "EDataType"
  end
  eClass "EReference", :abstract => false, :interface => false, :eSuperTypes => ["EStructuralFeature"], :instanceClassName => "FlexGen::ECore::EReference" do
    eAttribute "container", :changeable => false, :derived => true, :transient => true, :volatile => true, :eType => ""
    eAttribute "containment", :defaultValueLiteral => "false", :eType => ""
    eAttribute "resolveProxies", :defaultValueLiteral => "true", :eType => ""
    eReference "eOpposite", :eType => "EReference"
    eReference "eReferenceType", :changeable => false, :derived => true, :transient => true, :volatile => true, :lowerBound => 1, :eType => "EClass"
  end
  eClass "EStructuralFeature", :abstract => false, :interface => false, :eSuperTypes => ["ETypedElement"], :instanceClassName => "FlexGen::ECore::EStructuralFeature" do
    eAttribute "changeable", :defaultValueLiteral => "true", :eType => ""
    eAttribute "defaultValue", :changeable => false, :derived => true, :transient => true, :volatile => true, :eType => ""
    eAttribute "defaultValueLiteral", :eType => ""
    eAttribute "derived", :defaultValueLiteral => "false", :eType => ""
    eAttribute "transient", :defaultValueLiteral => "false", :eType => ""
    eAttribute "unsettable", :defaultValueLiteral => "false", :eType => ""
    eAttribute "volatile", :defaultValueLiteral => "false", :eType => ""
    eReference "eContainingClass", :eOpposite => "EClass.eStructuralFeatures", :eType => "EClass"
  end
  eClass "EFactory", :abstract => false, :interface => false, :eSuperTypes => ["EModelElement"], :instanceClassName => "FlexGen::ECore::EFactory" do
    eReference "ePackage", :resolveProxies => false, :eOpposite => "EPackage.eFactoryInstance", :transient => true, :lowerBound => 1, :eType => "EPackage"
  end
  eClass "ENamedElement", :abstract => false, :interface => false, :eSuperTypes => ["EModelElement"], :eSubTypes => ["EEnumLiteral", "EPackage", "ETypedElement"], :instanceClassName => "FlexGen::ECore::ENamedElement" do
    eAttribute "name", :eType => ""
  end
  eClass "EEnum", :abstract => false, :interface => false, :eSuperTypes => ["EDataType"], :instanceClassName => "FlexGen::ECore::EEnum" do
    eReference "eLiterals", :containment => true, :resolveProxies => false, :eOpposite => "EEnumLiteral.eEnum", :upperBound => -1, :eType => "EEnumLiteral"
  end
  eClass "EParameter", :abstract => false, :interface => false, :eSuperTypes => ["ETypedElement"], :instanceClassName => "FlexGen::ECore::EParameter" do
    eReference "eOperation", :eOpposite => "EOperation.eParameters", :eType => "EOperation"
  end
  eClass "EEnumLiteral", :abstract => false, :interface => false, :instanceClassName => "FlexGen::ECore::EEnumLiteral" do
    eAttribute "literal", :eType => ""
    eAttribute "value", :eType => ""
    eReference "eEnum", :eOpposite => "EEnum.eLiterals", :eType => "EEnum"
  end
  eClass "EAnnotation", :abstract => false, :interface => false, :eSuperTypes => ["EModelElement"], :instanceClassName => "FlexGen::ECore::EAnnotation" do
    eAttribute "source", :eType => ""
    eReference "eModelElement", :eOpposite => "EModelElement.eAnnotations", :eType => "EModelElement"
    eReference "details", :containment => true, :resolveProxies => false, :upperBound => -1, :eType => "EStringToStringMapEntry"
    eReference "contents", :containment => true, :resolveProxies => false, :upperBound => -1, :eType => "EObject"
    eReference "references", :upperBound => -1, :eType => "EObject"
  end
  eClass "EClass", :abstract => false, :interface => false, :eSuperTypes => ["EClassifier"], :instanceClassName => "FlexGen::ECore::EClass" do
    eAttribute "abstract", :eType => ""
    eAttribute "interface", :eType => ""
    eReference "eIDAttribute", :resolveProxies => false, :changeable => false, :derived => true, :transient => true, :volatile => true, :eType => "EAttribute"
    eReference "eAllAttributes", :changeable => false, :derived => true, :transient => true, :volatile => true, :upperBound => -1, :eType => "EAttribute"
    eReference "eAllContainments", :changeable => false, :derived => true, :transient => true, :volatile => true, :upperBound => -1, :eType => "EReference"
    eReference "eAllOperations", :changeable => false, :derived => true, :transient => true, :volatile => true, :upperBound => -1, :eType => "EOperation"
    eReference "eAllReferences", :changeable => false, :derived => true, :transient => true, :volatile => true, :upperBound => -1, :eType => "EReference"
    eReference "eAllStructuralFeatures", :changeable => false, :derived => true, :transient => true, :volatile => true, :upperBound => -1, :eType => "EStructuralFeature"
    eReference "eAllSuperTypes", :changeable => false, :derived => true, :transient => true, :volatile => true, :upperBound => -1, :eType => "EClass"
    eReference "eAttributes", :changeable => false, :derived => true, :transient => true, :volatile => true, :upperBound => -1, :eType => "EAttribute"
    eReference "eReferences", :changeable => false, :derived => true, :transient => true, :volatile => true, :upperBound => -1, :eType => "EReference"
    eReference "eOperations", :containment => true, :resolveProxies => false, :eOpposite => "EOperation.eContainingClass", :upperBound => -1, :eType => "EOperation"
    eReference "eStructuralFeatures", :containment => true, :resolveProxies => false, :eOpposite => "EStructuralFeature.eContainingClass", :upperBound => -1, :eType => "EStructuralFeature"
    eReference "eSuperTypes", :eOpposite => "eSubTypes", :upperBound => -1, :eType => "EClass"
    eReference "eSubTypes", :eOpposite => "eSuperTypes", :upperBound => -1, :eType => "EClass"
  end
  eClass "EPackage", :abstract => false, :interface => false, :instanceClassName => "FlexGen::ECore::EPackage" do
    eAttribute "nsPrefix", :eType => ""
    eAttribute "nsURI", :eType => ""
    eReference "eClassifiers", :containment => true, :eOpposite => "EClassifier.ePackage", :upperBound => -1, :eType => "EClassifier"
    eReference "eSubpackages", :containment => true, :eOpposite => "eSuperPackage", :upperBound => -1, :eType => "EPackage"
    eReference "eSuperPackage", :eOpposite => "eSubpackages", :eType => "EPackage"
    eReference "eFactoryInstance", :eOpposite => "EFactory.ePackage", :eType => "EFactory"
  end
  eClass "EDataType", :abstract => false, :interface => false, :instanceClassName => "FlexGen::ECore::EDataType" do
    eAttribute "serializable", :eType => ""
  end
  eClass "EModelElement", :abstract => false, :interface => false, :instanceClassName => "FlexGen::ECore::EModelElement" do
    eReference "eAnnotations", :containment => true, :resolveProxies => false, :eOpposite => "EAnnotation.eModelElement", :upperBound => -1, :eType => "EAnnotation"
  end
  eClass "EClassifier", :abstract => false, :interface => false, :eSuperTypes => ["ENamedElement"], :eSubTypes => ["EDataType"], :instanceClassName => "FlexGen::ECore::EClassifier" do
    eAttribute "defaultValue", :changeable => false, :derived => true, :transient => true, :volatile => true, :eType => ""
    eAttribute "instanceClass", :changeable => false, :derived => true, :transient => true, :volatile => true, :eType => ""
    eAttribute "instanceClassName", :eType => ""
    eReference "ePackage", :eOpposite => "EPackage.eClassifiers", :eType => "EPackage"
  end
  eClass "EStringToStringMapEntry", :abstract => false, :interface => false, :instanceClassName => "FlexGen::ECore::EStringToStringMapEntry" do
    eAttribute "key", :eType => ""
    eAttribute "value", :eType => ""
  end
  eClass "EOperation", :abstract => false, :interface => false, :eSuperTypes => ["ETypedElement"], :instanceClassName => "FlexGen::ECore::EOperation" do
    eReference "eContainingClass", :eOpposite => "EClass.eOperations", :eType => "EClass"
    eReference "eParameters", :containment => true, :resolveProxies => false, :eOpposite => "EParameter.eOperation", :upperBound => -1, :eType => "EParameter"
    eReference "eExceptions", :upperBound => -1, :eType => "EClassifier"
  end
  eClass "ETypedElement", :abstract => false, :interface => false, :instanceClassName => "FlexGen::ECore::ETypedElement" do
    eAttribute "lowerBound", :defaultValueLiteral => "0", :eType => ""
    eAttribute "ordered", :defaultValueLiteral => "true", :eType => ""
    eAttribute "unique", :defaultValueLiteral => "true", :eType => ""
    eAttribute "upperBound", :defaultValueLiteral => "1", :eType => ""
    eAttribute "many", :changeable => false, :derived => true, :transient => true, :volatile => true, :eType => ""
    eAttribute "required", :changeable => false, :derived => true, :transient => true, :volatile => true, :eType => ""
    eReference "eType", :eType => "EClassifier"
  end
end
