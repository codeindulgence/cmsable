// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  $('.cmsable_save').on('click', function() {
    var id = this.id.replace('cmsable_save_', ''),
        instance = this.id.replace('save', 'edit');
    $.post('/cmsable/contents/' + id, {
      _method:'put',
      content:{
        body:CKEDITOR.instances[instance].getData()
        }
      })
  });
});
