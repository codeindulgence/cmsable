// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(function() {

  CKEDITOR.disableAutoInline = true;

  $('.cmsable_edit').on('click', function() {
    $('#cmsable_control a').toggleClass('cmsable_on');
    if ($(this).hasClass('cmsable_on')) {
      $('.cmsable_editor').addClass('cmsable_reveal').attr('contenteditable', true);
      $('.cmsable_rich').each(function(idx, ele) {
        CKEDITOR.inline(ele);
      });
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
        token = that.getAttribute('data-token');

    var cmsables = [];

    // Submit plain text fields
    $('.cmsable_plain').each(function(idx, ele) {
      $ele = $(ele);
      cmsables.push({
        id: ele.id.replace(/\D/g, ''),
        model: $ele.data('model'),
        body: $ele.text()
      });
    });

    // Submit CKEditor fields
    $.each(CKEDITOR.instances, function(index, instance) {
      cmsables.push({
        id: instance.name.replace(/\D/g, ''),
        model: instance.element.$.getAttribute('data-model'),
        body: instance.getData()
      });
    });

    $.each(cmsables, function(idx, cmsable) {
      $.post('/cmsable/' + cmsable.id, {
                   _method: 'put',
                     model: cmsable.model,
        authenticity_token: token,
                   content: {
                     body: cmsable.body
                   }
      }, function(data) {
        if (idx == cmsables.length - 1) {
          $('#cmsable_control').removeClass('processing');
        }
      });
    });

    $('.cmsable_edit').click();
  });
});
