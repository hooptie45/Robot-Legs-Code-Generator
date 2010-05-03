require 'rubygems'
require 'flexgen/metamodel_builder'

module ASMetaModel
  extend FlexGen::MetamodelBuilder::ModuleExtension
  class NamedBase < FlexGen::MetamodelBuilder::MMBase 
    has_attr 'name', String  
  end
  class Base < FlexGen::MetamodelBuilder::MMBase ; end
  class Triggerable < NamedBase; end
  class Viewable < Triggerable; end
  
  class BaseSig < NamedBase; end
  class Sig < NamedBase; end
  class Actor < Triggerable; end
  class Cmd < Triggerable; end
  class View < Viewable; end
  class Attribute < NamedBase; end
  class App < NamedBase; end

  class Result < Sig; end
  class Form < View; end
  class Grid < View; end
  class Button < Triggerable; end
  class DefaultObject < Actor; end
  class Val < NamedBase; end
  class Actor
  end
  
  class Cmd
  end
  
  class Val
    has_attr 'view_type', String  
  end
  
  class Attribute
    has_attr 'view_type', String  
  end
  
  class App
    has_attr 'base', String
  end
  
  
  Triggerable.many_to_many 'triggers', Sig, 'triggerables'
  Triggerable.many_to_many 'watchers', Sig, 'watchables'
  Sig.has_one 'vo', Actor
  Sig.contains_many 'attributes', Val, 'context'
  Actor.contains_many 'attributes', Attribute, 'context'
  Actor.contains_many 'signals', Sig, 'context'
  DefaultObject.contains_many 'attributes', Val, 'context'
  DefaultObject.contains_many 'signals', Sig, 'context'
  
  
  App.contains_many 'models', Actor, 'app'
  App.contains_many 'signals', Sig, 'context'
  App.contains_many 'commands', Cmd, 'app'
  App.contains_many 'views', View, 'app'
  
  Cmd.contains_many 'signals', Sig, 'context'
  

  View.contains_many 'signals', Sig, 'context'
  View.contains_many 'forms', Form, 'view'
  View.contains_many 'grids', Grid, 'view'
  Form.contains_many 'inputs', Val, 'form'
  Form.contains_many 'buttons', Button, 'form'

end