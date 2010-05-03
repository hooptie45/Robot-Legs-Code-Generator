<% define 'Root', :for => View do %>
	<% package app.base do %>
		<% package 'view.components' do %>
			<% package actor.name.downcase do %>
				<% expand 'form/Mxml::Root', :foreach => forms %>
				<% expand 'form/Mediator::Root', :foreach => forms %>
			<% end %>
		<% end %>
	<% end %>
<% end %>

<% define 'View', :for => Form do %>
	<% package_file n = "#{model.actor.name}Form.mxml" do %>
		<% expand 'form/Mxml::Root', n, :for => Class %>
	<% end %>
	<% package_file n = "#{model.actor.name}FormMediator.as" do %>
		<% expand 'form/Mxml::Root', n %>
	<% end %>
<% end %>

<% define 'View', :for => Grid do %>
	<% package_file n = "#{model.actor.name}Grid.mxml" do %>
		
	<% end %>
	<% package_file n = "#{model.actor.name}GridMediator.as" do %>
		
	<% end %>
<% end %>

