module TemplatedForm
  
  # tell all of these methods to use TemplateFormBuilder
  [:form_for, :form_remote_for, :remote_form_for,:fields_for].each do |type|
    src = <<-end_src
      def templated_#{type}(object_name, *args, &proc)
        
        options = args.last.is_a?(Hash) ? args.pop : {}
        options[:builder] = TemplatedFormBuilder unless options.nil?
        value = #{type}(object_name, *(args << options), &proc)
        if value =~ /title/ then
          form_id = value.scan(/<form.*id=\"(.*?)\"/).flatten
          concat(build_watermark(form_id[0]),proc.binding)
        end
      end
    end_src
    module_eval src, __FILE__, __LINE__
  end

#if the object in the form have a title attribute add a watermark to the objects  
  def build_watermark(form_id)
<<-end_src
<script type="text/javascript" charset="utf-8">
$(document).ready
(
	function()
	{
	  $.each($('##{form_id} input[@title]'),
	    function(i)
	    {
	      if($("#" + $(this).attr("id") + "_watermark").length == 0)
	      {
	        $(this).watermark({
	          watermarkText:$(this).attr('title'),
	          watermarkCssClass: 'text'  
	        });
	      }
	    }
		);
	}	
);
</script>
end_src
  end
  
  
  def templated_form_script_tags
    javascript_include_tag "jquery.watermark"
  end
    
end

