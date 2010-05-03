require 'flexgen/environment'
require 'flexgen/template_language'
require 'flexgen/ecore/ecore'
require 'flexgen/ecore/ecore_ext'
require 'mmgen/mm_ext/ecore_mmgen_ext'

module MMGen

module MetamodelGenerator

	def generateMetamodel(rootPackage, out_file)
		tc = FlexGen::TemplateLanguage::DirectoryTemplateContainer.new(FlexGen::ECore, File.dirname(out_file))
		tpl_path = File.dirname(__FILE__) + '/templates'
		tc.load(tpl_path)
		tc.expand('metamodel_generator::GenerateMetamodel', File.basename(out_file), :for => rootPackage)
	end

end

end