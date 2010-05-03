$:.unshift File.dirname(__FILE__) + "/.."
$:.unshift File.dirname(__FILE__) + "."
require 'rubygems'
require 'fileutils'
require '../../metamodel/as'
require '../../metamodel/as_ext'
require 'flexgen/model_builder'
require 'flexgen/template_language'
require 'flexgen/array_extensions'
TEMPLATES_DIR = File.dirname(__FILE__)+"/templates"
OUTPUT_DIR = File.dirname(__FILE__)+"/generated"
describe "templates" do
  before :all do
    @tc = FlexGen::TemplateLanguage::DirectoryTemplateContainer.new(ASMetaModel, OUTPUT_DIR)
    @tc.load(TEMPLATES_DIR)
    MODEL = FlexGen::ModelBuilder.build(ASMetaModel) do
      app "App", :base => "com.shaunhannah" do
        # Models
        actor "Customer" do
          attribute "first_name", :view_type => "String"
          attribute "last_name", :view_type => "String"
        end

        # Signals
        sig "CreateCustomerSignal", :actor => "Customer"

        # Commands
        cmd "CreateCustomerCommand", :triggers => ["CreateCustomerSignal"]

        # Views
        view do
          modelView :actor => "Customer" do
            form do
              button "CreateCustomer", :triggers => "CreateCustomerSignal"
            end
          end
        end
      end
    end
    
  end
  before :each do
    
  end
  after :each do
    FileUtils.rm_rf OUTPUT_DIR
  end
  it "should render view" do
    @tc.expand('App::Root', :for => MODEL.first)
  end
  
  
end