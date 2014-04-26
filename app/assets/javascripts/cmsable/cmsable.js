// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {

  CKEDITOR.disableAutoInline = true;

  $('.cmsable_edit').on('click', function() {
    $('#cmsable_control a').toggleClass('cmsable_on');
    if ($(this).hasClass('cmsable_on')) {
      $('.cmsable_editor').addClass('cmsable_reveal').attr('contenteditable', true);
      CKEDITOR.inlineAll();
    }else{
      $('.cmsable_editor').removeClass('cmsable_reveal').attr('contenteditable', false);
      $.each(CKEDITOR.instances, function(index, instance) {
        instance.destroy();
      });
    }
  });

  $(document).on('click', '.cmsable_save.cmsable_on', function() {
    $('#cmsable_control').addClass('processing');
    var that = this,
        updated = 0,
        instances = 0;
    $.each(CKEDITOR.instances, function(index, instance) {
      instances++;
      var id = instance.name.replace(/\D/g, ''),
          model = instance.element.$.getAttribute('data-model'),
          token = that.getAttribute('data-token'),
          body = instance.getData();
      $.post('/cmsable/' + id, {
                   _method: 'put',
                     model: model,
        authenticity_token: token,
                   content: {
                     body: body
                   }
      }, function(data) {
        updated++;
        if (updated === instances) {
          $('#cmsable_control').removeClass('processing');
        }
      });
    });
    $('.cmsable_edit').click();
  });

});
