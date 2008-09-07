#modified form Advanced Rails Recipes


class TemplatedFormBuilder < ActionView::Helpers::FormBuilder
  
  def initialize(object_name, object, template, options, proc)
    super
  end
  
  #displays the error message for the field
  def error_message(field,options)
    errors = object.errors.on(field)
    message = String.new
    
    # if the label has not been expressly set use the field name
    message = "#{(options[:label] || field).to_s.humanize} " unless field == :base
    "#{message}#{errors.is_a?(Array) ? errors.to_sentence : errors}"
  end
  

  helpers = field_helpers +
    %w(date_select datetime_select time_select collection_select) +
    %w(collection_select select country_select time_zone_select)  -
    %w(label fields_for hidden_field) #these are skipped over
  

  helpers.each do |name|
    define_method name do |field, *args|
      options = args.detect {|argument| argument.is_a?(Hash)} || {}
      build_shell(field,options) do
        super
      end
    end
  end
  
  protected
  
  def build_shell(field,options)
    @template.capture do
      
      #Settings
      #:use_base - will only display the base error message set by the model
      #:label - can be anything the normal label method will take
                #:label=>["My Label",{:class=>"inline"}]
                #:label=>"My Label"
      #:message or :title will add a watermark to the element if its a textfield or textarea 
      template_options = {:field=>(options.delete(:use_base) ? :base : field),
                          :label=>options.delete(:label)}
      if options.include? :message then
        options[:title] = options.delete(:message)
      end
      
                          
      locals = { 
        :label    => label(field,*(template_options[:label])) ,
        #yields to build the requested element
        :element  => yield  
      }
      #only display errors associated with the entire model , added for attachment_fu
      if has_errors_on?(template_options[:field])
       
        options = { :partial => 'forms/field_with_errors' , 
                    :locals  =>  locals.merge!(:error => error_message(template_options[:field],template_options))} 
      else
        options = {:partial => 'forms/field' , :locals  => locals }       
      end
      @template.render options
    end
  end
  
  
  def has_errors_on?(field)
    !(object.nil? || object.errors.on(field).blank?)
  end
end