// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  $('.cmsable_save').on('click', function() {
    var id = this.id.replace(/\D/g, ''),
        instance = this.id.replace('save', 'edit'),
          model = this.getAttribute('data-model');
    $.post('/cmsable/contents/' + id, {
      _method:'put',
        model: model,
      content: {
         body: CKEDITOR.instances[instance].getData()
      }
    });
  });
});
