require 'flexgen/model_builder'
require 'metamodel/as'
include ASMetaModel
def auto_build
  FlexGen::ModelBuilder.build(ASMetaModel) do
    app "App", :base => "com.test" do
      # Models
      actor "Customer" do
        attribute "first_name", :view_type => "String"
        attribute "last_name", :view_type => "String"
        # Customer Signals
        sig "New"
        sig "Destroy"
      end
      
      actor "Order" do
        attribute "price", :view_type => "String"
        attribute "quantity", :view_type => "String"
        # Order Signals
        sig "New"
        sig "Destroy"
      end
      
      # App Signals
      sig "Init" do
        val "testing"
      end

      # Commands
      cmd "CreateCustomer",   :triggers => ["Customer.New", "Order.New"]
      cmd "LoadCustomers",    :triggers => ["App.Init"]
      cmd "DestroyCustomer",  :triggers => ["Customer.Destroy"]
      cmd "NewOrder",         :triggers => ["Order.New"]
      
      # Views
      view "CustomerView" do
        form :watchers => [ "Customer.New", "Customer.Destroy"] do
          button "CreateCustomer", :triggers => ["Customer.New"]
          button "DestroyCustomer", :triggers => ["Customer.Destroy"]
        end
      end
      
      view "OrderView" do
        form :watchers => ["Order.New", "Order.Destroy"] do
          button "CreateOrder", :triggers => ["Order.New"]
          button "DestroyCustomer", :triggers => ["Order.Destroy"]
        end
      end
    end
  end
end
MODEL = auto_build