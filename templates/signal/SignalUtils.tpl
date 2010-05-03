<% define 'RegisterSignals', :for => Sig do %>
	[Inject] public var <%= full_name_instance %>:<%= full_name %>;
<% end %>

<% define 'RegisterWatcherSignals', :for => Sig do %>
	<%= full_name_instance %>.add(on<%= full_name %>)
<% end %>


<% define 'DispatchButtonSignal', :for => Sig do %>
	<%= full_name_instance %>.dispatch(<%= vo_instance %>);
<% end %>

<% define 'WatcherFunctions', :for => Sig do %>
	private function on<%= full_name %>(<%= vo_instance %>:<%= vo_class %>):void
	{<%iinc%>

	<%idec%>}<%nl%>	
<% end %>


