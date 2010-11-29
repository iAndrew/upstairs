function EditBox(e) {
	this.container = $(e);
	this.fields = this.container.find('.editable-field');
	this.fields.makeItEditable();
	this.appendEditControls();
}

EditBox.prototype = {
	
	appendEditControls : function(){
		this.container.append('<a href="#"><img alt="Edit" src="/images/edit.png"/></a><div><button id="submit">Submit</button><button id="cancel">Cancel</button><span id="status"></span></div>');
		this.container.find('a').bind('click', {editor: this}, this.switchToEditMode);
		this.container.find('#cancel').bind('click', {editor: this}, this.cancel);
		this.container.find('#submit').bind('click', {editor: this}, this.submit);
		this.container.find('a').hide();
		this.hideEditControls();
	},
	
	mouseEnterLeaveHandler : function(event) {
		var action = event.type == 'mouseenter' ? 'fadeIn' : 'fadeOut';
		$(this).find('a')[action]();
	},
	
	switchToEditMode : function(event) {
		var editBox = event.data.editor;
		for(var i=editBox.fields.length-1;i>=0; i--) {
			$(editBox.fields[i]).data('editableField').activate();
		}
		editBox.showEditControls();
	},
	
	showEditControls : function() {
		this.container.find('button').show();
		this.container.unbind('mouseenter mouseleave', this.mouseEnterLeaveHandler);
		this.container.find('a').hide();
	},
	
	hideEditControls : function() {
		this.container.find('button').hide();
		this.container.bind('mouseenter mouseleave', this.mouseEnterLeaveHandler);
	},
	
	updateStatus : function(status) {
		this.container.find('#status').html("Status: " + status).fadeOut(1000);
	},
	
	submit: function(event) {
		var editBox = event.data.editor;
		editBox.ajax({
			"type"       : "post",
			"dataType"   : "text",
			"data"       : editBox.generateRequestData(),
			"success"    : function(res){
				editBox.populate(res);
				editBox.hideEditControls();
				editBox.updateStatus("Saved");
			},
			"error"		: function(xhr, status){
				editBox.updateStatus("Error");
			}
		});
		editBox.updateStatus("Updating...");
	},
	
	ajax : function(options) {
		options.url = this.url;
		options.beforeSend = function(xhr){ xhr.setRequestHeader("Accept", "application/json"); };
		return jQuery.ajax(options);
	},
	
	generateRequestData : function() {
		var data = "_method=put";
		var editableField;
		for(var i=0; i<this.fields.length; i++) {
			editableField = $(this.fields[i]).data('editableField');
			data += this.generateParamValuePar(editableField);
		}
		if (window.rails_authenticity_token) {
			data += "&authenticity_token="+encodeURIComponent(window.rails_authenticity_token);
		}
		return data;
	},
	
	generateParamValuePar : function(editableField) {
		return "&"+editableField.attributeName+'='+encodeURIComponent(editableField.getValue());
	},
	
	populate : function(data) {
		//if (jQuery.fn.jquery < "1.4") data = eval('(' + data + ')' );
		data = eval('(' + data + ')');
		for(var i=0; i<this.fields.length; i++) {
			editableField = $(this.fields[i]).data('editableField');
			editableField.element.html(data[editableField.attributeName]);
		}
	},
	
	cancel: function(event) {
		var editBox = event.data.editor;
		for(var i=0; i<editBox.fields.length; i++) {
			$(editBox.fields[i]).data('editableField').abort();
		}
		editBox.hideEditControls();
	}
}

jQuery.fn.editBox = function(holder) {
	this.each(function(){
		$(this).data('EditBox', new EditBox(this));
	})
	return this;
}

function EditableField(e) {
	this.element = jQuery(e);
	this.initOptions();
	this.bindForm();
}

EditableField.prototype = {
  
  activate : function() {
    this.oldValue = this.element.html();    
    this.activateForm();
  },
  
  abort : function() {
    this.element.html(this.oldValue)
  },
    
  activateForm : function() {
    alert("The form was not properly initialized. activateForm is unbound");
  },
    
  initOptions : function() {
    // Try parent supplied info
    var self = this;
    self.element.parents().each(function(){
      self.url           = self.url           || jQuery(this).attr("data-url");
      self.formType      = self.formType      || jQuery(this).attr("data-formtype");
      self.objectName    = self.objectName    || jQuery(this).attr("data-object");
      self.attributeName = self.attributeName || jQuery(this).attr("data-attribute");
    });
    // Try Rails-id based if parents did not explicitly supply something
    self.element.parents().each(function(){
      var res;
      if (res = this.id.match(/^(\w+)_(\d+)$/i)) {
        self.objectName = self.objectName || res[1];
      }
    });
    // Load own attributes (overrides all others)
    self.url           = self.element.attr("data-url")       || self.url      || document.location.pathname;
    self.formType      = self.element.attr("data-formtype")  || self.formtype || "input";
    self.objectName    = self.element.attr("data-object")    || self.objectName;
    self.attributeName = self.element.attr("data-attribute") || self.attributeName;
  },
  
  bindForm : function() {
    this.activateForm = EditableField.forms[this.formType].activateForm;
    this.getValue     = EditableField.forms[this.formType].getValue;
  },
  
  getValue : function() {
    alert("The form was not properly initialized. getValue is unbound");    
  }
}


EditableField.forms = {
  "input" : {
    activateForm : function() {
      this.element.html('<form action="javascript:void(0)" style="display:inline;"><input type="text" value="' + this.oldValue + '"></form>');
      this.element.find('input')[0].select();
    },
    
    getValue :  function() {
      return this.element.find("input").val();
    }
  },

  "textarea" : {
    activateForm : function() {
      this.element.html('<form action="javascript:void(0)" style="display:inline;"><textarea>' + this.oldValue + '</textarea></form>');
      this.element.find('textarea')[0].select();
    },
    
    getValue :  function() {
      return this.element.find("textarea").val();
    }
  }
}

jQuery.fn.makeItEditable = function() {
  this.each(function(){
    jQuery(this).data('editableField', new EditableField(this));
  })
  return this;
}











