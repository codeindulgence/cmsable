// CMSable javascript
$(function() {
  var link = document.createElement('a');
  link.innerHTML = 'Edit Page';
  link.setAttribute('class', 'cmsable_reveal');
  var $link = $(link);
  $link.click(function() {
    $(this).toggleClass('active');
    $('.cmsable_node').toggleClass('visible');
  })
  document.body.appendChild(link);
  $('.cmsable_begin_edit').click(function(e) {
    e.preventDefault();
    $link.click();
    $($(this).attr('href')).dialog({
      buttons:{
        'Save' : function() {
          console.log('TODO: save');
          $(this).dialog('close');
        }
      },
      close: function() {
        $link.click();
      }
    });
  });
});
