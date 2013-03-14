// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {
  $('.cmsable_save').on('click', function() {
    var id = this.id.replace(/\D/g, ''),
        instance = this.id.replace('save', 'edit'),
          model = this.getAttribute('data-model'),
          token = this.getAttribute('data-token');
    $.post('/cmsable/' + id, {
                 _method: 'put',
                   model: model,
      authenticity_token: token,
                 content: {
                   body: CKEDITOR.instances[instance].getData()
                 }
    });
  });
});
