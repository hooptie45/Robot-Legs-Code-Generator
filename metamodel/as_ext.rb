require "flexgen/name_helper"
module ASMetaModel
  include FlexGen::NameHelper
  module Actor::ClassModule
    def list_file_name
      "#{name}ListModel.as"
    end
    
    def file_name
      "#{name}.as"
    end
    
    def full_list_name
      list_file_name =~ /(\w*)\.\w+$/
      $1
    end
    
    def as_package
      "#{app.base}.model".gsub('/','.')
    end
    def as_list_package
      "#{app.base}.model.list".gsub('/','.')
    end
    def model_instance
      firstToLower name
    end
    def model_class
      name
    end
    def model
      name
    end
    def vo_class
      name
    end
    def vo_instance
      firstToLower name
    end
  end
  
  module DefaultObject::ClassModule
    def full_name
      file_name =~ /(\w*)\.\w+$/
      $1
    end
    def file_name
      "#{name}.as"
    end
    def as_package
      "junk".gsub('/','.')
    end
    def model_instance
      name.downcase
    end
    def model_class
      name
    end
    def model
      name
    end
    def vo_class
      "Object"
    end
    def vo_instance
      "object"
    end
  end
  
  module App::ClassModule
    def forms
      a=[]
      views.each{|v| a<<v.forms.collect}
      a.flatten!
      a
    end
    def all
      a = []

      models.each {|m| a<<m.signals.collect }
      a<<commands.collect
      a<<models.collect
      commands.each {|e| a<<e.signals.collect}
      a<<signals.collect
      views.each {|e| a<<e.signals.collect}
      views.each {|e| a<<e.forms.collect}
      views.forms.each {|e| a<<e.signals.collect}
      puts a.flatten!
      a
    end
    def full_name
      file_name =~ /(\w*)\.\w+$/
      $1
    end    
    def file_name
      "AppContext.as"
    end
    def all_signals
      sigs = []
      sigs<<signals.collect
      models.each { |e| sigs << e.signals.collect }
      views.each { |e| sigs << e.signals.collect }
      commands.each { |e| sigs << e.signals.collect }
      sigs.flatten!
    end
    def model_instance
      firstToLower full_name
    end
    def model_class
      full_name
    end
    def model
      full_name
    end
    def as_package
      "#{base}".gsub('/','.')
    end
    def context_root
      "#{as_package}"
    end
  end
    
  module View::ClassModule
    def full_name
      file_name =~ /(\w*)\.\w+$/
      $1
    end    
    def file_name
      "#{name}.as"
    end
    def as_package
      "#{app.base}.view.components.#{actor.name.downcase}".gsub('/','.')
    end
    def model_instance
      firstToLower full_name
    end
    def model_class
      full_name
    end
    def model
      full_name
    end
    def actor=(actor)
      @actor = actor
    end
    def actor
      # @@models ||= []
      # app.models.each {|m| @@models << m} if (@@models.length == 0 && app.name =~ /App/)
      #   
      # @@models.each do |model|
      #   regex = Regexp.new(model.name)
      #   unless regex.match(self.full_name).nil?
      #     @actor = model
      #   end
      # end
      # if @actor 
      #   @actor 
      # else
      #   default = ASMetaModel::DefaultObject.new(:name => "Object")
      #   unless forms.nil?
      #     forms.collect.first.getInputs.each do |i|
      #       default.addAttributes i
      #     end
      #   end
      #   @actor = default
      # end
      @@models ||= []
      app.models.each {|m| @@models << m} if (@@models.length == 0 && app.name =~ /App/)
      @@models.each do |model|
        regex = Regexp.new(model.name)
        unless regex.match(self.name.to_s).nil?
          #puts "Got It Self:#{name}  Model:#{model.name} "
          @actor = model
        end
      end
      
      if @actor 
        @actor 
      else
        default = ASMetaModel::DefaultObject.new(:name => name)
        @actor = default
      end
    end
  end
  
  module Form::ClassModule
    def full_name
      file_name =~ /(\w*)\.\w+$/
      $1
    end    
    def full_mediator_name
      mediator_file_name =~ /(\w*)\.\w+$/
      $1
    end
    def file_name
      "#{view.actor.name}Form.mxml"
    end
    def mediator_file_name
      "#{view.actor.name}FormMediator.as"
    end
    def as_package
      "#{view.app.base}.view.components.#{view.actor.name.downcase}".gsub('/','.')
    end
    def model_instance
      firstToLower full_name
    end
    def model_class
      full_name
    end
    def model
      full_name
    end
  end
  
  module Cmd::ClassModule
    def full_name
      file_name =~ /(\w*)\.\w+$/
      $1
    end    
    def file_name
      "#{name}Command.as"
    end
    def as_package
      "#{app.base}.commands".gsub('/','.')
    end
    def model_instance
      firstToLower full_name
    end
    def model_class
      full_name
    end
    def model
      full_name
    end
  end
  
  
  module Sig::ClassModule
    def full_name
      file_name =~ /(\w*)\.\w+$/
      $1
    end    
    def file_name
      "#{name}#{context.name}Signal.as"
    end
    def as_package
      "#{context.as_package}.signals".gsub('/','.')
    end
    def model_instance
      firstToLower full_name
    end
    def model_class
      full_name
    end
    def model
      full_name
    end
    def full_name_instance
      firstToLower full_name
    end
    def getVO
       if name.to_s =~ /Actor/
         context.model_instance
       elsif context.class.to_s =~ /Default/
          "Object"
       elsif actor
          actor.model_instance
        else
          ""
       end
    end
    def getVO_instance
       firstToLower getVO
    end
    def getVO_class
      firstToUpper getVO
    end
    def actor=(actor)
      @actor = actor
    end
    def actor
      @@models ||= []
      context.models.each {|m| @@models << m} if (@@models.length == 0 && context.name =~ /App/)
        
      @@models.each do |model|
        regex = Regexp.new(model.name)
        unless regex.match(self.full_name).nil?
          #@actor = model
          self.setVo(model)
        end
      end
      if @actor 
        @actor 
      else
        default = ASMetaModel::DefaultObject.new(:name => "Object")
        attributes.each do |i|
          default.addAttributes i
        end
        @actor = default
      end
    end
    alias vo_class getVO_class
    alias vo_instance getVO_instance
  end
  
  module Triggerable::ClassModule
    def full_name
      file_name =~ /(\w*)\.\w+$/
      $1
    end    
    def file_name
      "#{name}.as"
    end
    def signals
      triggers.collect
    end
    def model_instance
      triggers.first.context.name.downcase
    end
    def model_class
      triggers.first.context.name
    end
    def model
      triggers.first.context.name
    end
  end

  module Result::ClassModule
    def full_name
      file_name =~ /(\w*)\.\w+$/
      $1
    end    
    def file_name
      "#{name}.as"
    end
  end
end