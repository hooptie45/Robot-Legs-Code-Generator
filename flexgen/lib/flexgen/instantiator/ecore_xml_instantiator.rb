require 'flexgen/ecore/ecore'
require 'flexgen/instantiator/abstract_xml_instantiator'
require 'flexgen/array_extensions'

class ECoreXMLInstantiator < AbstractXMLInstantiator
  
  include FlexGen::ECore
  
  INFO = 0
  WARN = 1
  ERROR = 2
  
  def initialize(env, loglevel=ERROR)
    @env = env
    @rolestack = []
    @elementstack = []
    @loglevel = loglevel
  end
  
  def start_tag(prefix, tag, namespaces, attributes)
    eRef = nil
    if @elementstack.last
      eRef = eAllReferences(@elementstack.last).find{|r|r.name == tag}
      if eRef
        if attributes["xsi:type"] && attributes["xsi:type"] =~ /ecore:(\w+)/
          class_name = $1
          attributes.delete("xsi:type")
        else 
          class_name = eRef.eType.name
        end
      else
        raise "Reference not found: #{tag} on #{@elementstack.last}"
      end
    else
      class_name = tag
    end
    
    eClass = FlexGen::ECore.ecore.eClassifiers.find{|c| c.name == class_name}
    if eClass
      obj = FlexGen::ECore.const_get(class_name).new
      if eRef
        if eRef.many
          @elementstack.last.addGeneric(eRef.name, obj)
        else
          @elementstack.last.setGeneric(eRef.name, obj)
        end
      end
      @env << obj
      @elementstack.push obj
    else
      log WARN, "Class not found: #{class_name}"
      @elementstack.push nil
    end
  end
  
  def end_tag(prefix, tag)
    @elementstack.pop
  end
  
  ResolverDescription = Struct.new(:object, :attribute, :value)
  
  def set_attribute(attr, value)
    return unless @elementstack.last
    eFeat = eAllStructuralFeatures(@elementstack.last).find{|a| a.name == attr}
    if eFeat.is_a?(EReference)
      rd = ResolverDescription.new
      rd.object = @elementstack.last
      rd.attribute = attr
      rd.value = value
      @resolver_descs << rd
    elsif eFeat
      value = true if value == "true" && eFeat.eType == EBoolean
      value = false if value == "false" && eFeat.eType == EBoolean
      value = value.to_i if eFeat.eType == EInt
      @elementstack.last.setGeneric(attr, value)
    else
      log WARN, "Feature not found: #{attr} on #{@elementstack.last}"
    end
  end
  
  def instantiate(str)
    @resolver_descs = []
#    puts "Instantiating ..."
    super(str, 1000)
    rootpackage = @env.find(:class => EPackage).first
#    puts "Resolving ..."
    @resolver_descs.each do |rd|
      refed = find_referenced(rootpackage, rd.value)
      feature = eAllStructuralFeatures(rd.object).find{|f| f.name == rd.attribute}
      raise StandardError.new("StructuralFeature not found: #{rd.attribute}") unless feature
      if feature.many
        rd.object.setGeneric(feature.name, refed)
      else
        rd.object.setGeneric(feature.name, refed.first)
      end
    end
  end
  
  def eAllReferences(element)
    @eAllReferences ||= {}
    @eAllReferences[element.class] ||= element.class.ecore.eAllReferences
  end
  
  def eAllAttributes(element)
    @eAllAttributes ||= {}
    @eAllAttributes[element.class] ||= element.class.ecore.eAllAttributes
  end
  
  def eAllStructuralFeatures(element)
    @eAllStructuralFeatures ||= {}
    @eAllStructuralFeatures[element.class] ||= element.class.ecore.eAllStructuralFeatures
  end
  
  def find_referenced(context, desc)
    desc.split(/\s+/).collect do |r|
      if r =~ /^#\/\d*\/([\w\/]+)/
        find_in_context(context, $1.split('/'))
      end
      end.compact
    end
    
    def find_in_context(context, desc_elements)
      if context.is_a?(EPackage)
        r = (context.eClassifiers + context.eSubpackages).find{|c| c.name == desc_elements.first}
      elsif context.is_a?(EClass)
        r = context.eStructuralFeatures.find{|s| s.name == desc_elements.first}
      else
        raise StandardError.new("Don't know how to find #{desc_elements.join('/')} in context #{context}")
      end
      if r
        if desc_elements.size > 1
          find_in_context(r, desc_elements[1..-1])
        else
          r
        end
      else
        log WARN, "Can not follow path, element #{desc_elements.first} not found within #{context}(#{context.name})"
      end
    end
    
    def log(level, msg)
      puts %w(INFO WARN ERROR)[level] + ": " + msg if level >= @loglevel
    end
  end