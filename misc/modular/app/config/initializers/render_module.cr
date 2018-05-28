# HACK: See https://github.com/damianham/amber_render_module/pull/1
module Amber::Controller::Helpers::RenderModule
  private macro render_template(filename, path = "src/views")
      {% if filename.id.split("/").size > 2 %}
        Kilt.render("{{filename.id}}")
      {% else %}
        Kilt.render("#{{{path}}}/{{filename.id}}")
      {% end %}
    end
end
