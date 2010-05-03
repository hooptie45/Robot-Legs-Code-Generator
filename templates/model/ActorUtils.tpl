<% define 'DeclarePrivateAttributes', :for => Attribute do %>
	private var _<%= name %>:<%= view_type %>;
<% end %>

<% define 'GetterAndSetterFunctions', :for => Actor do %>
	<% for attribute in attributes %>
		<% expand 'Getter', :for => attribute %>
		<%nl%>
		<% expand 'Setter', :for => attribute %>
		<%nl%>
	<% end %>
<% end %>


<% define 'Getter', :for => Attribute do %>
	public function set <%= name %>(value:<%= view_type %>):void
	{<%iinc%>
		_<%= name %> = value;
	<%idec%>}
<% end %>

<% define 'Setter', :for => Attribute do %>
	public function get <%= name %>():<%= view_type %>
	{<%iinc%>
		return _<%= name %>;
	<%idec%>}
<% end %>

<% define 'Assign', :for => Attribute do %>
	<%= context.model_instance %>._<%= name %> = this._<%= name %>;
<% end %>



