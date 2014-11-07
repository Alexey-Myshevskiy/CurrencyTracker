//= require jquery
//= require jquery_ujs
//= require_self
//= require_tree .
$(document).ready(function() {
    $(".check_all").click(function() {
        $('input[type="checkbox"]' ,$(this.form)).prop("checked", $(this).prop('checked'));
    })
})