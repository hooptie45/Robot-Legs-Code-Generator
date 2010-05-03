<% 
def actor?(model)
	#puts "#{(model.class.to_s !~/Actor/)} \t\t#{model.class.to_s}"
	!(model.class.to_s !~/Actor/)
end
def done?(model, reset = false)	
	skip=true
	if model
		skip = false
		@done = (reset) ? {} : @done || {}
		if @done.has_key?(model)
			skip = true
		end 
		@done[model] = true
		#puts "#{@done.keys.length}\t\t=> #{skip} => #{model.full_name}\t\t #{model.class.to_s}"
	end
	skip
end
def skip?(model)
	done = (done?(model) and actor?(model)) ? "@ TRUE @" : "FALSE"
	!(done?(model) and actor?(model))
end
%>

<% define 'Reset', :for => Object do %>
	<% done? nil, true %>
<% end %>

<% define 'Root', :for => Cmd do |t| %>
	<% expand 'ImportCommand', :for => t unless done?(t) %>
<% end %>

<% define 'Root', :for => Actor do |t| %>
	<% expand 'ImportSig', :for => t unless skip?(t) %>
<% end %>

<% define 'Root', :for => DefaultObject do |t| %>
	<% puts "Skipping DefaultObject: #{name}" %>
<% end %>

<% define 'Root', :for => View do |t| %>
	<% expand 'ImportForm', :for => t unless done?(t)  %>
<% end %>

<% define 'Root', :for => Form do |t| %>
	<% expand 'ImportForm', :for => t unless done?(t) %>
<% end %>

<% define 'Root', :for => Actor do |t| %>
	<% expand 'ImportActor', :for => t unless skip?(t) %>
	<% expand 'ImportList', :for => t unless skip?(t) %>
<% end %>

<% define 'Root', :for => Sig do |t| %>
	<% expand 'ImportSig', :for => t  %>
<% end %>

<% define 'ImportForm', :for => Form do  %>
	import <%= as_package.gsub('/', '.') %>.<%= full_name %> 
	import <%= as_package.gsub('/', '.') %>.<%= full_mediator_name %> 
<% end %>

<% define 'ImportView', :for => View do  %>
	import <%= as_package.gsub('/', '.') %>.<%= full_name %> 
	import <%= as_package.gsub('/', '.') %>.<%= full_mediator_name %> 
<% end %>

<% define 'ImportSig', :for => Sig do  %>
	import <%= as_package.gsub('/', '.') %>.<%= full_name %> 
<% end %>

<% define 'ImportCommand', :for => Cmd do  %>
	import <%= as_package.gsub('/', '.') %>.<%= full_name %> 
<% end %>

<% define 'ImportActor', :for => Actor do  %>
	import <%= as_package.gsub('/', '.') %>.<%= full_name %> 
<% end %>

<% define 'ImportList', :for => Actor do  %>
	import <%= as_list_package.gsub('/', '.') %>.<%= full_list_name %> 
<% end %>
