module TemplatedForm
  
  # tell all of these methods to use TemplateFormBuilder
  [:form_for, :fields_for, :form_remote_for, :remote_form_for].each do |type|
    src = <<-end_src
      def templated_#{type}(object_name, *args, &proc)
        options = args.last.is_a?(Hash) ? args.pop : {}
        options[:builder] = TemplatedFormBuilder unless options.nil?
        #{type}(object_name, *(args << options), &proc)
      end
    end_src
    module_eval src, __FILE__, __LINE__
  end
  
  module Helper
     def templated_form_script_tags
       javascript_include_tag "jquery.watermark"
     end
  end
    
end