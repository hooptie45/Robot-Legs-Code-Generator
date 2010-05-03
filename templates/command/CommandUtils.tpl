<% define 'Register', :for => Sig do %>
	<% if vo %>
		[Inject] public var <%= vo.model_instance %>:<%= vo.model_class %>
	<% end %>
<% end %>
