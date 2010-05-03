require 'flexgen/metamodel_builder'

module StatemachineMetamodel
  extend FlexGen::MetamodelBuilder::ModuleExtension

  class Statemachine < FlexGen::MetamodelBuilder::MMBase
    has_attr 'name', String
  end

  class State < FlexGen::MetamodelBuilder::MMBase
    has_attr 'name', String
  end
  Statemachine.contains_many 'state', State, 'statemachine'

  class CompositeState < State
  end
  CompositeState.contains_many 'subState', State, 'compositeState'

  class Transition < FlexGen::MetamodelBuilder::MMBase
  end
  Statemachine.contains_many 'transition', Transition, 'statemachine'

  class Trigger < FlexGen::MetamodelBuilder::MMBase
    has_attr 'name', String
  end
  Statemachine.contains_many 'trigger', Trigger, 'statemachine'
  Transition.has_one 'trigger', Trigger

  Transition.many_to_one 'source', State, 'outTrans'
  Transition.many_to_one 'target', State, 'inTrans'
end


