<% define 'Root', :for => Sig do %>
	<% package as_package do %>
	<% package_file n = file_name do %>
	package <%= as_package %>
	{<%iinc%>
		<%nl%>
		<% expand '/import/ImportUtils::Root', actor, :for => actor  %>
		import org.osflash.signals.Signal;
		<%nl%>
		public class <%= full_name %> extends Signal
		{<%iinc%>
	
			public function <%= full_name %>()
			{<%iinc%>
				super(<%= vo_class %>);
			<%idec%>}
		<%idec%>}
	<%idec%>}
	<% end %>
	<% end %>
<% end %>

<% define 'Test', :any => [Sig, BaseSig] do %>
	<%= name %>
<% end %>
