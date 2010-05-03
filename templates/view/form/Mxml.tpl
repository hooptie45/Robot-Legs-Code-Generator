<% define 'Root', :for => Form do %>
	<% package "#{view.app.base}.view.components.#{view.actor.name.downcase}" do %>
	<% package_file n = file_name do %>
		<?xml version="1.0"?>
		<s:VGroup xmlns:fx="http://ns.adobe.com/mxml/2009" xmlns:s="library://ns.adobe.com/flex/spark"<%iinc%><%iinc%><%iinc%>
				 xmlns:mx="library://ns.adobe.com/flex/mx" xmlns:signals="org.osflash.signals.*"><%idec%><%idec%>
			 <fx:Declarations>
				<%iinc%><% expand 'ButtonSignals', :foreach => buttons %><%idec%>
			 </fx:Declarations>
			 <s:VGroup><%iinc%>
					<mx:Form><%iinc%>
						<% expand 'FormItem', :foreach => view.actor.attributes %>
						 <s:HGroup>
							<%iinc%><% expand 'Button', :foreach => buttons %><%idec%>
						 </s:HGroup><%idec%>
					</mx:Form><%idec%>
			 </s:VGroup><%idec%>
		</s:VGroup><%idec%>
	<% end %>
	<% end %>
<% end %>

<% define 'Button', :for => Button do %>
	<s:Button id="<%= name %>" label="<%= name %>" click="signalFor<%= name %>Button.dispatch()"/>
<% end %>

<% define 'ButtonSignals', :for => Button do %>
	 <signals:Signal id="signalFor<%= name %>Button"/>
<% end %>

<% define 'FormItem', :any => [Attribute, Val] do %>
	<mx:FormItem label="<%= name %>"><%iinc%>
			<s:TextInput id="<%= name %>"/><%idec%>
	</mx:FormItem>	
<% end %>
