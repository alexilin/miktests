function remove_fields(link) {
  $(link).prev("input[type=hidden]").val("1");
  $(link).closest(".fields").hide();
}

function remove_image(link) {
	$(link).prev("input[type=hidden]").val("");
  $(link).closest(".fields").hide();
}

function add_fields(link, association, content) {
  var new_id = new Date().getTime();
  var regexp = new RegExp("new_" + association, "g")
  $(link).parent().before(content.replace(regexp, new_id));
}

function use_image_answer(link) {
	$(link).prev(".image-text").hide();
	$(link).prev(".image-answer").show();	
}