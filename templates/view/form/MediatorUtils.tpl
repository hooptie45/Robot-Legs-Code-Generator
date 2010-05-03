<% define 'ButtonSignalFunctions', :for => Button do %>
	private function on<%= name %>ButtonClick():void
	{<%iinc%>
		var <%= model_instance %>:<%= model_class %> = this.<%= model_instance %>;
		<%nl%>
		<% expand '/signal/SignalUtils::DispatchButtonSignal', :foreach => triggers %>
	<%idec%>}<%nl%>
<% end %>

<% define 'RegisterButtonSignals', :for => Button do %>
	view.signalFor<%= name %>Button.add(on<%= name %>ButtonClick)
<% end %>

<% define 'SetActorFunction', :for => Actor do %>
	protected function set <%= vo_instance %>(<%= vo_instance %>:<%= vo_class %>):void
	{<%iinc%>
		<% expand 'SetViewAttributes', :foreach => attributes %>
	<%idec%>}<%nl%>
<% end %>

<% define 'GetActorFunction', :for => Actor do %>
	protected function get <%= vo_instance %>():<%= vo_class %>
	{<%iinc%>
		var <%= vo_instance %>:<%= vo_class %> = new <%= vo_class %>();
		<% expand 'GetViewAttributes', :foreach => attributes %>
		return <%= vo_instance %>;
	<%idec%>}<%nl%>
<% end %>

<% define 'GetViewAttributes', :any => [Attribute, Val] do %>
	<%= context.vo_instance %>.<%= name %> = view.<%= name %>.text;
<% end %>

<% define 'SetViewAttributes', :any => [Attribute, Val] do %>
	view.<%= name %>.text = <%= context.vo_instance %>.<%= name %>;
<% end %>