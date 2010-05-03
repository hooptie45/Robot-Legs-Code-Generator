require 'metamodel/statemachine_metamodel'

include StatemachineMetamodel

def buildModel
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