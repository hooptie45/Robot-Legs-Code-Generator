require 'flexgen/metamodel_builder'

module StatemachineMetamodel
   extend FlexGen::MetamodelBuilder::ModuleExtension
   include FlexGen::MetamodelBuilder::DataTypes

end

class StatemachineMetamodel::State < FlexGen::MetamodelBuilder::MMBase
   has_attr 'name', String 
end

class StatemachineMetamodel::CompositeState < StatemachineMetamodel::State
end

class StatemachineMetamodel::Transition < FlexGen::MetamodelBuilder::MMBase
end

class StatemachineMetamodel::Statemachine < FlexGen::MetamodelBuilder::MMBase
   has_attr 'name', String 
end

class StatemachineMetamodel::Trigger < FlexGen::MetamodelBuilder::MMBase
   has_attr 'name', String 
end


StatemachineMetamodel::CompositeState.contains_many 'subState', StatemachineMetamodel::State, 'compositeState' 
StatemachineMetamodel::State.one_to_many 'inTrans', StatemachineMetamodel::Transition, 'target' 
StatemachineMetamodel::State.one_to_many 'outTrans', StatemachineMetamodel::Transition, 'source' 
StatemachineMetamodel::Statemachine.contains_many 'state', StatemachineMetamodel::State, 'statemachine' 
StatemachineMetamodel::Statemachine.contains_many 'transition', StatemachineMetamodel::Transition, 'statemachine' 
StatemachineMetamodel::Transition.has_one 'trigger', StatemachineMetamodel::Trigger 
StatemachineMetamodel::Statemachine.contains_many 'trigger', StatemachineMetamodel::Trigger, 'statemachine' 
