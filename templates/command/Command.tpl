<% define 'Root', :for => Cmd do %>
	<% package as_package do %>
	<% package_file file_name do %>
	
	/********************************************************************************

	*********************************************************************************/

	package <%= as_package %>
	{<%iinc%>
		<% expand '/import/ImportUtils::Reset' %>
		<% for trigger in triggers %>
			<% expand '/import/ImportUtils::Root', trigger, :for => trigger %>
			<% expand '/import/ImportUtils::Root', trigger.vo, :for => trigger.vo if trigger.vo %>
		<% end %>
		<% for signal in signals %>
			<% expand '/import/ImportUtils::Root', signal, :for => signal %>
			<% for m in signal.actor %>
				<% expand '/import/ImportUtils::Root', m, :for => m %>
			<% end %>
		<% end %>
		import org.robotlegs.mvcs.Command;
		<%nl%><%nl%>
		public class <%= full_name %> extends Command
		{<%iinc%>
			<%nl%>
				<% expand 'CommandUtils::Register', :foreach => triggers %>
			<%nl%>

			override public function execute():void
			{<%iinc%>
				
			<%idec%>}
		<%idec%>}
	<%idec%>}
	<% end %>
	<% end %>
<% end %>