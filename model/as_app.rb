require 'metamodel/as'
require 'flexgen/model_builder'
require 'metamodel/statemachine_metamodel'
require 'metamodel/as'
include ASMetamodel

def buildModel
  app = App.new(:name => "TestApp", 
  :models => [
    customer = Model.new(:name => "Customer", :attributes => [
      first_name = Attribute.new(:name => "first_name", :type => "string"),
      last_name = Attribute.new(:name => "last_name", :type => "string")
    ]),
    order = Model.new(:name => "Order", :attributes => [
      price = Attribute.new(:name => "price", :type => "number")
    ])
  ],
  :controllers => [
    addCustomerController = Controller.new(:name => "AddCustomerController", :signals => [
      addCustomer = Signal.new(:name => "AddCustomerSignal")
  ]))
                                  
                                    
  
  sm = Statemachine.new(:name => 'Aircondition')
  off = State.new(:name => 'Off', :statemachine => sm)
  on = CompositeState.new(:name => 'On', :statemachine => sm, :subState => [
    heat = State.new(:name => 'Heating'),
    cool = State.new(:name => 'Cooling')
  ])
  powerButton = Trigger.new(:name => "PowerButton")
  modeButton = Trigger.new(:name => "ModeButton")
  sm.transition = [
    Transition.new(:trigger => powerButton, :source => off, :target => heat),
    Transition.new(:trigger => modeButton, :source => heat, :target => cool),
    Transition.new(:trigger => modeButton, :source => cool, :target => heat),
    Transition.new(:trigger => powerButton, :source => on, :target => off)
  ]
  sm
end

MODEL = [ buildModel ]