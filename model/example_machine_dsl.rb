require '../rgen-0.5.0/lib/rgen/model_builder'
require 'metamodel/statemachine_metamodel'
require 'metamodel/as'
# MODEL = FlexGen::ModelBuilder.build(StatemachineMetamodel) do
#   statemachine "Aircondition" do
#     state "Off"
#     compositeState "On" do
#         state "Heating"
#         state "Cooling"
#     end
#     trigger "ModeButton"
#     trigger "PowerButton"
#     transition :source => "Off", :target => "On.Heating", :trigger => "PowerButton"
#     transition :source => "On.Heating", :target => "On.Cooling", :trigger => "ModeButton"
#     transition :source => "On.Cooling", :target => "On.Heating", :trigger => "ModeButton"
#     transition :source => "On", :target => "Off", :trigger => "PowerButton"
#   end
# end
# Statemachine.contains_many 'trigger', Trigger, 'statemachine'
# Transition.has_one 'trigger', Trigger
# Statemachine.contains_many 'transition', Transition, 'statemachine'
# CompositeState.contains_many 'subState', State, 'compositeState'
# Statemachine.contains_many 'state', State, 'statemachine'# 
# Transition.many_to_one 'source', State, 'outTrans'
# Transition.many_to_one 'target', State, 'inTrans'

# def buildModel
#   sm = Statemachine.new(:name => 'Aircondition')
#   off = State.new(:name => 'Off', :statemachine => sm)
#   on = CompositeState.new(:name => 'On', :statemachine => sm, :subState => [
#     heat = State.new(:name => 'Heating'),
#     cool = State.new(:name => 'Cooling')
#   ])
#   powerButton = Trigger.new(:name => "PowerButton")
#   modeButton = Trigger.new(:name => "ModeButton")
#   sm.transition = [
#     Transition.new(:trigger => powerButton, :source => off, :target => heat),
#     Transition.new(:trigger => modeButton, :source => heat, :target => cool),
#     Transition.new(:trigger => modeButton, :source => cool, :target => heat),
#     Transition.new(:trigger => powerButton, :source => on, :target => off)
#   ]
#   sm
# end
# 
# class Actor < FlexGen::MetamodelBuilder::MMBase; end
# class Controller < FlexGen::MetamodelBuilder::MMBase; end
# class Attribute < FlexGen::MetamodelBuilder::MMBase; end
# class App < FlexGen::MetamodelBuilder::MMBase; end
include ASMetaModel
# def build
#   closer = Actor.new(:name => "Closer", :attributes => [  Attribute.new(:name => "first_name", :type => 'String'),
#                     Attribute.new(:name => "last_name", :type => 'String') ]))
#   customer = View.new( :name =>"Customer", 
#                         :attributes => [  Attribute.new(:name => "first_name", :type => 'String'),
#                                           Attribute.new(:name => "last_name", :type => 'String') ])
# 
#   order =  Actor.new (:name => "Order", 
#                       :attributes => [  Attribute.new(:name => "price", :type => 'Number')])
#                       
#   new_customer_signal = Sig.new :name => "gsf", :model => customer
#   destroy_customer_signal = Sig.new :name => "gghsf", :model => customer
#   update_customer_signal = Sig.new :name => "gdgsf", :model => customer
#   
#   new_order_signal = Sig.new :name => "ghsf", :model => order
#   destroy_order_signal = Sig.new :name => "ggsf", :model => order
#   update_order_signal = Sig.new :name => "gsff", :model => order  
#   
#   order_command = Command.new(:name => "OrderCommand", :triggers => [new_order_signal, update_order_signal], :results => [update_order_signal])
#   app = App.new(:name=>"TestApp", :models => [customer, order], :commands => [order_command])                       
# end


def auto_build
  FlexGen::ModelBuilder.build(ASMetaModel) do
    app "App" do
      actor "Customer" do
        attribute "first_name", :type => "String"
        attribute "last_name", :type => "String"
      end
      cmd "OrderCommand" do
        trigger "NewOrderSignal", :actor => "Customer"
      end
    end
  end
end
MODEL = auto_build

