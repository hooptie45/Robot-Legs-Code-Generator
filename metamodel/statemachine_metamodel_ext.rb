module StatemachineMetamodel

module CompositeState::ClassModule
  def allSubStates
    subState + subState.allSubStates 
  end
end

module State::ClassModule
  def allSubStates
    []
  end
  def qualifiedName
    compositeState ? compositeState.qualifiedName + "_" + name : name
  end
  def allOutTrans
    compositeState ? compositeState.allOutTrans + outTrans : outTrans
  end
end

end