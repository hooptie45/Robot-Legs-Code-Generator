# FlexGen Framework
# (c) Martin Thiede, 2006

require 'erb'
require 'flexgen/metamodel_builder/metamodel_description.rb'

module FlexGen

module MetamodelBuilder

# This module provides methods which can be used to setup a metamodel element.
# The module is used to +extend+ MetamodelBuilder::MMBase, i.e. add the module's 
# methods as class methods.
# 
# MetamodelBuilder::MMBase should be used as a start for new metamodel elements.
# See MetamodelBuilder for an example.
# 
module BuilderExtensions
	include NameHelper

    class FeatureBlockEvaluator
      def self.eval(block, props1, props2=nil)
        return unless block
        e = self.new(props1, props2)
        e.instance_eval(&block)
      end
      def initialize(props1, props2)
        @props1, @props2 = props1, props2
      end
      def annotation(hash)
        @props1.annotations << Intermediate::Annotation.new(hash)
      end
      def opposite_annotation(hash)
        raise "No opposite available" unless @props2
        @props2.annotations << Intermediate::Annotation.new(hash)
      end
    end
    
	def has_attr(role, target_class=nil, raw_props={}, &block)
		props = AttributeDescription.new(target_class, _ownProps(raw_props).merge({
			:name=>role, :upperBound=>1}))
		raise "No opposite available" unless _oppositeProps(raw_props).empty?
		FeatureBlockEvaluator.eval(block, props)
		_build_internal(props)
	end
	
	# Add a single attribute or unidirectional association.
	# 'role' specifies the name which is used to access the attribute.
	# 'target_class' specifies the type of objects which can be held by this attribute.
	# If no target class is given, String will be default.
	# 
	# This class method adds the following instance methods, where 'role' is to be 
	# replaced by the given role name:
	# 	class#role	# getter
	# 	class#role=(value)	# setter
	# 
	def has_one(role, target_class=nil, raw_props={}, &block)
		props = ReferenceDescription.new(target_class, _ownProps(raw_props).merge({
			:name=>role, :upperBound=>1, :containment=>false}))
		raise "No opposite available" unless _oppositeProps(raw_props).empty?
		FeatureBlockEvaluator.eval(block, props)
		_build_internal(props)
	end

	# Add an unidirectional _many_ association.
	# 'role' specifies the name which is used to access the attribute.
	# 'target_class' is optional and can be used to fix the type of objects which
	# can be referenced by this association.
	# 
	# This class method adds the following instance methods, where 'role' is to be 
	# replaced by the given role name:
	# 	class#addRole(value)	
	# 	class#removeRole(value)
	# 	class#role	# getter, returns an array
	# Note that the first letter of the role name is turned into an uppercase 
	# for the add and remove methods.
	# 
	def has_many(role, target_class=nil, raw_props={}, &block)
		props = ReferenceDescription.new(target_class, _setManyUpperBound(_ownProps(raw_props).merge({
			:name=>role, :containment=>false})))
		raise "No opposite available" unless _oppositeProps(raw_props).empty?
		FeatureBlockEvaluator.eval(block, props)
		_build_internal(props)
	end
	
	def contains_one_uni(role, target_class=nil, raw_props={}, &block)
		props = ReferenceDescription.new(target_class, _ownProps(raw_props).merge({
			:name=>role, :upperBound=>1, :containment=>true}))
		raise "No opposite available" unless _oppositeProps(raw_props).empty?
		FeatureBlockEvaluator.eval(block, props)
		_build_internal(props)
	end

	def contains_many_uni(role, target_class=nil, raw_props={}, &block)
		props = ReferenceDescription.new(target_class, _setManyUpperBound(_ownProps(raw_props).merge({
			:name=>role, :containment=>true})))
		raise "No opposite available" unless _oppositeProps(raw_props).empty?
		FeatureBlockEvaluator.eval(block, props)
		_build_internal(props)
	end
	
	# Add a bidirectional one-to-many association between two classes.
	# The class this method is called on is refered to as _own_class_ in 
	# the following.
	# 
	# Instances of own_class can use 'own_role' to access _many_ associated instances
	# of type 'target_class'. Instances of 'target_class' can use 'target_role' to
	# access _one_ associated instance of own_class.
	# 
	# This class method adds the following instance methods where 'ownRole' and
	# 'targetRole' are to be replaced by the given role names:
	# 	own_class#addOwnRole(value)
	# 	own_class#removeOwnRole(value)
	# 	own_class#ownRole
	# 	target_class#targetRole
	# 	target_class#targetRole=(value)
	# Note that the first letter of the role name is turned into an uppercase 
	# for the add and remove methods.
	# 
	# When an element is added/set on either side, this element also receives the element
	# is is added to as a new element.
	# 
	def one_to_many(target_role, target_class, own_role, raw_props={}, &block)
		props1 = ReferenceDescription.new(target_class, _setManyUpperBound(_ownProps(raw_props).merge({
			:name=>target_role, :containment=>false})))
		props2 = ReferenceDescription.new(self, _oppositeProps(raw_props).merge({
			:name=>own_role, :upperBound=>1, :containment=>false}))
		FeatureBlockEvaluator.eval(block, props1, props2)
		_build_internal(props1, props2)
	end

	def contains_many(target_role, target_class, own_role, raw_props={}, &block)
		props1 = ReferenceDescription.new(target_class, _setManyUpperBound(_ownProps(raw_props).merge({
			:name=>target_role, :containment=>true})))
		props2 = ReferenceDescription.new(self, _oppositeProps(raw_props).merge({
			:name=>own_role, :upperBound=>1, :containment=>false}))
		FeatureBlockEvaluator.eval(block, props1, props2)
		_build_internal(props1, props2)
	end
	
	# This is the inverse of one_to_many provided for convenience.
	def many_to_one(target_role, target_class, own_role, raw_props={}, &block)
		props1 = ReferenceDescription.new(target_class, _ownProps(raw_props).merge({
			:name=>target_role, :upperBound=>1, :containment=>false}))
		props2 = ReferenceDescription.new(self, _setManyUpperBound(_oppositeProps(raw_props).merge({
			:name=>own_role, :containment=>false})))
		FeatureBlockEvaluator.eval(block, props1, props2)
		_build_internal(props1, props2)
	end
	
	# Add a bidirectional many-to-many association between two classes.
	# The class this method is called on is refered to as _own_class_ in 
	# the following.
	# 
	# Instances of own_class can use 'own_role' to access _many_ associated instances
	# of type 'target_class'. Instances of 'target_class' can use 'target_role' to
	# access _many_ associated instances of own_class.
	# 
	# This class method adds the following instance methods where 'ownRole' and
	# 'targetRole' are to be replaced by the given role names:
	# 	own_class#addOwnRole(value)
	# 	own_class#removeOwnRole(value)
	# 	own_class#ownRole
	# 	target_class#addTargetRole
	# 	target_class#removeTargetRole=(value)
	# 	target_class#targetRole
	# Note that the first letter of the role name is turned into an uppercase 
	# for the add and remove methods.
	# 
	# When an element is added on either side, this element also receives the element
	# is is added to as a new element.
	# 
	def many_to_many(target_role, target_class, own_role, raw_props={}, &block)
		props1 = ReferenceDescription.new(target_class, _setManyUpperBound(_ownProps(raw_props).merge({
			:name=>target_role, :containment=>false})))
		props2 = ReferenceDescription.new(self, _setManyUpperBound(_oppositeProps(raw_props).merge({
			:name=>own_role, :containment=>false})))
		FeatureBlockEvaluator.eval(block, props1, props2)
		_build_internal(props1, props2)
	end
	
	# Add a bidirectional one-to-one association between two classes.
	# The class this method is called on is refered to as _own_class_ in 
	# the following.
	# 
	# Instances of own_class can use 'own_role' to access _one_ associated instance
	# of type 'target_class'. Instances of 'target_class' can use 'target_role' to
	# access _one_ associated instance of own_class.
	# 
	# This class method adds the following instance methods where 'ownRole' and
	# 'targetRole' are to be replaced by the given role names:
	# 	own_class#ownRole
	# 	own_class#ownRole=(value)
	# 	target_class#targetRole
	# 	target_class#targetRole=(value)
	# 
	# When an element is set on either side, this element also receives the element
	# is is added to as the new element.
	# 
	def one_to_one(target_role, target_class, own_role, raw_props={}, &block)
		props1 = ReferenceDescription.new(target_class, _ownProps(raw_props).merge({
			:name=>target_role, :upperBound=>1, :containment=>false}))
		props2 = ReferenceDescription.new(self, _oppositeProps(raw_props).merge({
			:name=>own_role, :upperBound=>1, :containment=>false}))
		FeatureBlockEvaluator.eval(block, props1, props2)
		_build_internal(props1, props2)
	end
	
	def contains_one(target_role, target_class, own_role, raw_props={}, &block)
		props1 = ReferenceDescription.new(target_class, _ownProps(raw_props).merge({
			:name=>target_role, :upperBound=>1, :containment=>true}))
		props2 = ReferenceDescription.new(self, _oppositeProps(raw_props).merge({
			:name=>own_role, :upperBound=>1, :containment=>false}))
		FeatureBlockEvaluator.eval(block, props1, props2)
		_build_internal(props1, props2)
	end
		
	def _metamodel_description # :nodoc:
		@metamodel_description ||= []
  end

  def _add_metamodel_description(desc) # :nodoc
		@metamodel_description ||= []
    @metamodelDescriptionByName ||= {}
    @metamodel_description.delete(@metamodelDescriptionByName[desc.value(:name)])
    @metamodel_description << desc 
    @metamodelDescriptionByName[desc.value(:name)] = desc
  end
  
  def abstract
    @abstract = true
  end
  
  def _abstract_class
    @abstract || false
  end
	
	def inherited(c)
	  c.send(:include, c.const_set(:ClassModule, Module.new))
	end
		
	protected
		
	# Central builder method
	# 
	def _build_internal(props1, props2=nil)
		_add_metamodel_description(props1)
		if props1.is_a?(ReferenceDescription) && props1.many?
			_build_many_methods(props1, props2)
		else
			_build_one_methods(props1, props2)
		end
		if props2
			# this is a bidirectional reference
			props1.opposite, props2.opposite = props2, props1
			other_class = props1.impl_type			
			other_class._add_metamodel_description(props2)
			raise "Internal error: second description must be a ReferenceDescription" \
				unless props2.is_a?(ReferenceDescription)
			if props2.many?
				other_class._build_many_methods(props2, props1)
			else
				other_class._build_one_methods(props2, props1)
			end
		end
	end
	
	# To-One association methods
	# 
	def _build_one_methods(props, other_props=nil)
		name = props.value(:name)
		other_role = other_props && other_props.value(:name)
		other_kind = other_props && ( other_props.many? ? :many : :one )

		if props.value(:derived)
			build_derived_method(name, props, :one)
		else
			@@one_read_builder ||= ERB.new <<-CODE
			
				def <%= name %>
				  <% if props.is_a?(AttributeDescription) && props.value(:defaultValueLiteral) %>
					<% defVal = props.value(:defaultValueLiteral) %>
                    <% defVal = '"'+defVal+'"' if props.impl_type == String %>
                    <% defVal = ':'+defVal if props.impl_type.is_a?(DataTypes::Enum) && props.impl_type != DataTypes::Boolean %>
					@<%= name %>.nil? ? <%= defVal %> : @<%= name %>
				  <% else %>
				    @<%= name %>
				  <% end %>
				end
				alias get<%= firstToUpper(name) %> <%= name %>

			CODE
			self::ClassModule.module_eval(@@one_read_builder.result(binding))
		end
		
		if props.value(:changeable)
			@@one_write_builder ||= ERB.new <<-CODE
				
				def <%= name %>=(val)
					return if val == @<%= name %>
					<%= type_check_code("val", props) %>
					oldval = @<%= name %>
					@<%= name %> = val
					<% if other_role && other_kind %>
						oldval._unregister<%= firstToUpper(other_role) %>(self) unless oldval.nil?
						val._register<%= firstToUpper(other_role) %>(self) unless val.nil?
					<% end %>
				end 
				alias set<%= firstToUpper(name) %> <%= name %>=

				def _register<%= firstToUpper(name) %>(val)
					@<%= name %> = val
				end
        
				def _unregister<%= firstToUpper(name) %>(val)
					@<%= name %> = nil
				end
        
			CODE
			self::ClassModule.module_eval(@@one_write_builder.result(binding))

		end
	end
	
	# To-Many association methods
	# 
	def _build_many_methods(props, other_props=nil)
		name = props.value(:name)
		other_role = other_props && other_props.value(:name)
		other_kind = other_props && ( other_props.many? ? :many : :one )

		if props.value(:derived)
			build_derived_method(name, props, :many)
		else
			@@many_read_builder ||= ERB.new <<-CODE
			
				def <%= name %>
					( @<%= name %> ? @<%= name %>.dup : [] )
				end
				alias get<%= firstToUpper(name) %> <%= name %>
							
			CODE
			self::ClassModule.module_eval(@@many_read_builder.result(binding))
		end
		
		if props.value(:changeable)
			@@many_write_builder ||= ERB.new <<-CODE
		
				def add<%= firstToUpper(name) %>(val)
					@<%= name %> = [] unless @<%= name %>
					return if val.nil? || @<%= name %>.any?{|e| e.object_id == val.object_id} 
					<%= type_check_code("val", props) %>
					@<%= name %>.push val
					<% if other_role && other_kind %>
						val._register<%= firstToUpper(other_role) %>(self)
					<% end %>
				end
				
				def remove<%= firstToUpper(name) %>(val)
					@<%= name %> = [] unless @<%= name %>
					@<%= name %>.each_with_index do |e,i|
						if e.object_id == val.object_id
							@<%= name %>.delete_at(i)
    						<% if other_role && other_kind %>
								val._unregister<%= firstToUpper(other_role) %>(self)
    						<% end %>
							return
						end
	        		end    
				end
        
        def <%= name %>=(val)
          return if val.nil?
          raise _assignmentTypeError(self, val, Array) unless val.is_a? Array
          get<%= firstToUpper(name) %>.each {|e|
            remove<%= firstToUpper(name) %>(e)
          }
          val.each {|v|
            add<%= firstToUpper(name) %>(v)
          }
        end
				alias set<%= firstToUpper(name) %> <%= name %>=
        
        def _register<%= firstToUpper(name) %>(val)
          @<%= name %> = [] unless @<%= name %>
          @<%= name %>.push val
        end

        def _unregister<%= firstToUpper(name) %>(val)
          @<%= name %>.delete val
        end
        
			CODE
			self::ClassModule.module_eval(@@many_write_builder.result(binding))
		end		
				
	end	
  
	private

	def build_derived_method(name, props, kind)
		raise "Implement method #{name}_derived instead of method #{name}" \
			if (public_instance_methods+protected_instance_methods+private_instance_methods).include?(name)
		@@derived_builder ||= ERB.new <<-CODE
		
			def <%= name %>
				raise "Derived feature requires public implementation of method <%= name %>_derived" \
					unless respond_to?(:<%= name+"_derived" %>)
				val = <%= name %>_derived
				<% if kind == :many %>
					raise _assignmentTypeError(self,val,Array) unless val && val.is_a?(Array)
					val.each do |v|
						<%= type_check_code("v", props) %>
					end
				<% else %>
					<%= type_check_code("val", props) %>
				<% end %>	
				val
			end
			alias get<%= firstToUpper(name) %> <%= name %>
			#TODO final_method :<%= name %>
			
		CODE
		self::ClassModule.module_eval(@@derived_builder.result(binding))
	end
	
	def type_check_code(varname, props)
		code = ""
		if props.impl_type.is_a?(Class)
			code << "unless #{varname}.nil? or #{varname}.is_a? #{props.impl_type}\n"
			expected = props.impl_type.to_s
		elsif props.impl_type.is_a?(FlexGen::MetamodelBuilder::DataTypes::Enum)
			code << "unless #{varname}.nil? or [#{props.impl_type.literals_as_strings.join(',')}].include?(#{varname})\n"
		    expected = "["+props.impl_type.literals_as_strings.join(',')+"]"
		else
			raise StandardError.new("Unkown type "+props.impl_type.to_s)
		end
		code << "raise _assignmentTypeError(self,#{varname},\"#{expected}\")\n"
		code << "end"
		code		
	end	
	
	def _ownProps(props)
	  Hash[*(props.select{|k,v| !(k.to_s =~ /^opposite_/)}.flatten)]
  end

	def _oppositeProps(props)
    r = {}
	  props.each_pair do |k,v|
      if k.to_s =~ /^opposite_(.*)$/
        r[$1.to_sym] = v
      end
    end
    r
  end

  def _setManyUpperBound(props)
    props[:upperBound] = -1 unless props[:upperBound].is_a?(Integer) && props[:upperBound] > 1
    props
  end
    
end

end

end