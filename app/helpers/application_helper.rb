# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  include ActionView::Helpers
  
  def owner?
    @teacher.id == current_user.id
  end       

  def link_to_remove_fields(name, f, field_name = :_destroy)
    f.hidden_field(field_name) + link_to_function("<span>#{name}</span>", "remove_fields(this)", :class => "redLink", :title => "remove")
  end

  def link_to_add_fields(name, f, association)
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, :child_index => "new_#{association}") do |builder|
      render(association.to_s.singularize + "_fields", :f => builder)
    end
    link_to_function("<span>#{name}</span>", h("add_fields(this, \"#{association}\", \"#{escape_javascript(fields)}\")"), :class => "greenLink")
  end
end
