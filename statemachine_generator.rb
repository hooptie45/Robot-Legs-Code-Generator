$:.unshift File.dirname(__FILE__) + "/.."
$:.unshift File.dirname(__FILE__) + "."
require 'rubygems'
require '../metamodel/as'
require 'metamodel/as_ext'
require 'model/as_app_dsl'
require 'flexgen/template_language'
require 'flexgen/array_extensions'
require 'fileutils'
def generate
  out = File.join(File.dirname(__FILE__),"../../AMF/rgenOutput/app/flex/src/")
  out2 = File.join(File.dirname(__FILE__),"../../AMF/signal/app/flex/src/")
  FileUtils.rm_rf out + "com"
  tc = FlexGen::TemplateLanguage::DirectoryTemplateContainer.new(ASMetaModel, out2)
  tc.load(File.dirname(__FILE__)+'/templates')
  tc.expand('App::Root', :for => MODEL.first)
end
generate