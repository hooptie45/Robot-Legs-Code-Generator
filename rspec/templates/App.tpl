<% define 'Root', :for => App do %>
	<% package base do %>
	<% expand 'Base', :foreach => models %>
	<% expand 'Command', :foreach => commands %>
	<% end %>
<% end %>

<% define 'Base', :for => Actor do %>
    <% file "models/"<<name<<".rb" do %>
        <% for a in attributes %>
    		<%= a.name %>
    		<%= a.view_type %>
    	<% end %>
		<% expand 'Attribute', :foreach => attributes %>
		
    <% end %>
<% end %>

<% define 'Command', :for => Cmd do %>
	<% file 'commands/'<<name<<'.as' do %>
		class <%= name %>
		{<%iinc%>
		<% expand 'Trigger', :foreach => triggers %>
		<%idec%>}
	<% end %>
<% end %>




<% define 'Trigger', :for => Sig do %>
	<%= name %>
	<%= actor.name %>
	{<%iinc%>
	<% expand 'Attribute', :foreach => actor.attributes %>
	<%idec%>}
<% end %>

<% define 'Attribute', :for => Attribute do %>
	<%= name %>
	<%= view_type %>
<% end %>