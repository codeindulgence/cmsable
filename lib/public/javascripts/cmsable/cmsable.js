// CMSable javascript
$(function() {
  var edit_link = document.createElement('a');
  edit_link.innerHTML = 'Edit Page';
  edit_link.setAttribute('class', 'cmsable_reveal');
  $(edit_link).click(function() {
    $('.cmsable_begin_edit').toggleClass('visible');
  })
  document.body.appendChild(edit_link);
});
