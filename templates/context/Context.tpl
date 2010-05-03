<% define 'Root', :for => App do %>
	<% package as_package do %>
	<% package_file n = file_name do %>	
	package <%= as_package %>
	{<%iinc%><%nl%>
		<% for model in models %>
			<% expand '/import/ImportUtils::Root', model, :for => model %>
			<% for signal in model.signals %>
				<% expand '/import/ImportUtils::Root', signal, :for => signal %>
			<% end %>
		<% end %>
		<% for signal in signals %>
			<% expand '/import/ImportUtils::Root', signal, :for => signal %>
			<% expand '/import/ImportUtils::Root', signal.actor, :for => signal.actor %>
		<% end %>
		<% for view in views %>
			<% for form in view.forms %>
				<% expand '/import/ImportUtils::Root', form, :for => form %>
			<% end %>
		<% end %>
		<% for command in commands %>
			<% expand '/import/ImportUtils::Root', command, :for => command %>
		<% end %>
		<% for command in commands %>
			<% for trigger in command.triggers %>
			<% expand '/import/ImportUtils::Root', command, :for => command %>
			<% end %>
		<% end %>
		import org.osflash.signals.Signal;
		import org.robotlegs.mvcs.SignalContext;
		<%nl%><%nl%>
		public class <%= full_name %> extends SignalContext
		{<%iinc%>
		<%nl%>
		<% for command in commands %>
			<% expand '/signal/SignalUtils::RegisterSignals', :foreach => command.triggers %>
		<% end %>
		<%nl%>
			public function <%= full_name %>()
			{<%iinc%>
				super();
			<%idec%>}
		<%nl%>

			override public function startup():void
			{<%iinc%>

				
				<%nl%>
				
				<% for view in views %>
				<% expand 'Reg', :foreach => view.forms %>
				<% end %>
				
				<%nl%>
			
				<% expand 'Reg', :foreach => models %>
				
				<%nl%>
				
				<% for command in commands %>
					<% expand 'Reg', command, :foreach => command.triggers %>
				<% end %>
				
			<%idec%>}
		<%idec%>}
	<%idec%>}
	<% end %>
	<% end %>
<% end %>

<% define 'Reg', :for => Form do %>
	mediatorMap.mapView(<%= full_name %>, <%= full_mediator_name %>);
<% end %>

<% define 'Reg', :for => Sig do |command| %>
	signalCommandMap.mapSignalClass(<%= model_class %>, <%= command.model_class %>, true);
<% end %>

<% define 'Reg', :for => Actor do %>
	injector.mapSingleton(<%= full_list_name %>);
<% end %>

