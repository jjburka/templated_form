/*
 *	Watermark plugin
 *	Version: 0.6
 *	jQuery 1.2.6
 *	 
 *	Author: Gonzalo Villar
 *
 *	TODO:
*		- Inherit all the watermarked element CSS
 * 
*/
(function($){

    function CreateDummyInput(jElement, options, tagName)
    {
        var watermarkText = (options.watermarkText) ? options.watermarkText : jElement.attr('title');
		var dummyType = (tagName == 'INPUT') ? '<input type="text">' : '<textarea>';
        var dummyInput = $(dummyType)
            .attr('id', jElement.attr('id') + '_watermark')
            .addClass(options.watermarkCssClass)
			.addClass('watermarkPluginCustomClass') //workaround to fix some caching? problem in FF3. Used in window.unload hook to remove watermarks from the DOM
            .val(watermarkText)
			.css({overflowY: jElement.css('overflow-y'), overflowX: jElement.css('overflow-x')});
			
        if(jElement.height() > 0)
            dummyInput.css({height: jElement.height(), width: jElement.width()});

        dummyInput.hide();
        jElement.before(dummyInput);
		return dummyInput;
    }

    function MakeWatermark(element, options)
    {
        element.each(function(){			
            var thisEl = jQuery(this);

            var dummyInput = CreateDummyInput(thisEl, options, thisEl.attr('tagName').toUpperCase());

            dummyInput.focus(function(e){
                $(this).hide();
                thisEl.show().focus();
            });
            
            thisEl.blur(function(e){
                if(this.value == '')
                {
                    $(this).hide();
                    dummyInput.show();
                }
            });

            thisEl.blur();

        });

        return element;
    }

	$(window).unload(function(){
		$('.watermarkPluginCustomClass').remove();
	});

    $.fn.watermark = function(options){ return MakeWatermark(this, options);}	

})(jQuery);