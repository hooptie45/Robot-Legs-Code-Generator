<% define 'Root', :for => App do %>
	<% package base do %>
	
	<% expand 'model/Actor::Root', :foreach => models %>
	<% expand 'model/list/ListModel::Root', :foreach => models %>
	
	<% expand 'signal/Signal::Root', :foreach => all_signals %>
	
	<% expand 'command/Command::Root', :foreach => commands %>
	<% expand 'view/ViewBase::Root', :foreach => views %>
	<% expand 'context/Context::Root' %>
	<% end %>
<% end %>


