<% define 'Root', :for => Actor do %>
	<% package as_list_package  do %>
	<% package_file n =  list_file_name do %>
	package <%= as_list_package %>
	{<%iinc%>
		<%nl%>
	<% for signal in signals %>
		<% expand '/import/ImportUtils::Root', signal, :for => signal %>
		<% expand '/import/ImportUtils::Root', signal.actor, :for => signal.actor %>
		import <%= as_package %>.<%= full_name %>
	<% end %>
		import flash.utils.Dictionary;
		import mx.collections.ArrayCollection;
		import org.robotlegs.mvcs.Actor;
		<%nl%>
		public class <%= model_class %>ListModel extends Actor
		{<%iinc%>
			private const <%= model_instance %>Map:Dictionary = new Dictionary(false);
			private var _autoIncrement<%= model_class %>ID:Number = 1;
			<%nl%>
			<% expand '/signal/SignalUtils::RegisterSignals', :foreach => signals %>
			<%nl%><%nl%>
			public function init():void
			{<%iinc%>

			<%idec%>}<%nl%>

			public function <%= model_class %>ListModel()
			{<%iinc%>

			<%idec%>}<%nl%>

			public function get autoIncrement<%= model_class %>ID():uint
			{<%iinc%>
				while (_autoIncrement<%= model_class %>ID in <%= model_instance %>Map)
				{<%iinc%>
					_autoIncrement<%= model_class %>ID++;
				<%idec%>}
				return _autoIncrement<%= model_class %>ID;
			<%idec%>}<%nl%><%nl%>

			public function <%= model_instance %>s():ArrayCollection
			{<%iinc%>
				var a:ArrayCollection = new ArrayCollection();
				for each(var <%= model_instance %>:<%= model_class %> in <%= model_instance %>Map)
				{<%iinc%>
					a.addItem(<%= model_instance %>);
				<%idec%>}
				return a;
			<%idec%>}<%nl%>

			public function get<%= model_class %>ByID(id:Number):<%= model_class %>
			{<%iinc%>
				return <%= model_instance %>Map[id];
			<%idec%>}<%nl%>

			public function unmap<%= model_class %>(<%= model_instance %>:<%= model_class %>):void
			{<%iinc%>
				delete <%= model_instance %>Map[<%= model_instance %>.id];
			<%idec%>}<%nl%>

			public function map<%= model_class %>(<%= model_instance %>:<%= model_class %>):void
			{<%iinc%>
				if (!get<%= model_class %>ByID(<%= model_instance %>.id))
				{<%iinc%>
					<%= model_instance %> = <%= model_instance %>.clone(autoIncrement<%= model_class %>ID);
				<%idec%>}
				else
				{<%iinc%>
				<%idec%>}
				<%= model_instance %>Map[<%= model_instance %>.id] = <%= model_instance %>;
			<%idec%>}
		<%idec%>}
	<%idec%>}
	<% end %>
	<% end %>
<% end %>