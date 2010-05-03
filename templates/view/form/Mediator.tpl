<% define 'Root', :for => Form do %>
	<% package as_package do %>
	<% package_file n = mediator_file_name do %>
	package <%= as_package %>
	{<%iinc%>

		<% for signal in view.actor.signals %>

			<% expand '/import/ImportUtils::Root', signal, :for =>signal %>
		<% end %>
		<% expand '/import/ImportUtils::Root', view.actor, :for =>view.actor %>


		import mx.collections.ArrayCollection;

		import org.robotlegs.mvcs.Mediator;
		<%nl%><%nl%>

		<%nl%>
		public class <%= full_mediator_name %> extends Mediator
		{<%iinc%>

		<% 	sigs =[] 
			for button in buttons 	
		   		sigs << button.triggers.collect
		 	end 
			sigs << watchers.collect
		   	sigs.flatten!.uniq! %>
		<% expand '/signal/SignalUtils::RegisterSignals', :foreach => sigs %>
			

			<%nl%>
			[Inject] public var view:<%= full_name %>;
			<%nl%>
			override public function onRegister():void
			{<%iinc%>
				// View Button Events
				<% expand 'MediatorUtils::RegisterButtonSignals', :foreach => buttons %>
				<%nl%>
				// Watchers
				<% expand '/signal/SignalUtils::RegisterWatcherSignals', :foreach => watchers %>

			<%idec%>}
			<%nl%>
			<% expand '/signal/SignalUtils::WatcherFunctions', :foreach => watchers %>
			<% expand 'MediatorUtils::ButtonSignalFunctions', :foreach => buttons %>
			<% expand 'MediatorUtils::GetActorFunction', :for => view.actor %>
			<% expand 'MediatorUtils::SetActorFunction', :for => view.actor %>
		<%idec%>}
	<%idec%>}
	<% end %>
	<% end %>
<% end %>
