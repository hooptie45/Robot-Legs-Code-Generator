<% define 'Root', :for => Actor do %>
	<% package as_package do %>
	<% package_file n = file_name do %>
	package <%= as_package %>
	{<%iinc%>
		<%nl%>
		<% for signal in signals %>
			<% expand '/import/ImportUtils::Root', signal, :for => signal %>
			<% expand '/import/ImportUtils::Root', signal.actor, :for => signal.actor %>
		<% end %>
		import org.robotlegs.mvcs.Actor;
		<%nl%>
		
		public class <%= model_class %> extends Actor
		{<%iinc%>
			private var _id:Number;
			<% expand 'ActorUtils::DeclarePrivateAttributes', :foreach => attributes %>
			
			<%nl%>
			public function get id():Number
			{<%iinc%>
				return _id;
			<%idec%>}
			<%nl%>
			public function set id(value:Number):void
			{<%iinc%>
				_id = value;
			<%idec%>}
			<%nl%>
			public function <%= name %>()
			{<%iinc%>
				super();
			<%idec%>}
			<%nl%>
			<% expand 'ActorUtils::GetterAndSetterFunctions' %>
			<%nl%>
			public function clone(tid:Number = 0):<%= name %>
			{<%iinc%>
				var <%= model_instance %>:<%= model_class %> = new <%= model_class %>();

				<% expand 'ActorUtils::Assign', :foreach => attributes %>
				return <%= model_instance %>;
			<%idec%>}
		<%idec%>}
	<%idec%>}
	<% end %>
	<% end %>
<% end %>
