// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery
//= require jquery_ujs
//= require dropzone


$(document).on('turbolinks:load', function(){
  var dropzone = $('.dropzone-area');
  var dropzone2 = $('.dropzone-area2');
  var appendzone = $('.dropzone-container2')
  var dropzone_box = $('.dropzone-box');
  var images = [];
  var inputs  =[];
  var input_area = $('.input_area');
  var preview = $('#preview');
  var preview2 = $('#preview2');

  $(document).on('change', 'input[type= "file"].upload-image',function(event) {
    var file = $(this).prop('files')[0];
    var reader = new FileReader();
    inputs.push($(this));
    var img = $(`<div class= "img_view"><img width="113px", height=auto></div>`);
    img.css({
      'float': "left",
      'height': "100%",
      'margin': '0 5px'
    })

    reader.onload = function(e) {
      var btn_wrapper = $('<div class="btn_wrapper"><div class="btn edit">編集</div><div class="btn delete">削除</div></div>');
      img.append(btn_wrapper);
      img.find('img').attr({
        src: e.target.result
      })
    }

    reader.readAsDataURL(file);
    images.push(img);


    // imagesが６枚以上
    if(images.length >= 6) {
      // appendzone.css({
      //   'display': 'block'
      // })
      // dropzone.css({
      //   'display': 'none'
      // })

      console.log(images)

      // ６枚目以降の画像を抽出
      var pickup_images = images.slice(5);

      console.log(pickup_images)

      $.each(pickup_images, function(index, image) {
        image.attr('data-image', index+5);
        preview2.append(image);
        dropzone2.css({
          'width': `calc(100% - (20% * ${images.length - 5}))`
        })
      })

    // ５枚のとき
    } else if(images.length == 5) {
      console.log(images)

      $('#preview').empty();
        $.each(images, function(index, image) {
          image.attr('data-image', index);
          preview.append(image);
        })
        // dropzone.css({
        //   'width': `calc(100% - (20% * ${images.length}))`
        // })
        appendzone.css({
          'display': 'block'
        })
        dropzone.css({
          'display': 'none'
        })


    // imagesが４枚以下
    } else {
        console.log(images)

        $('#preview').empty();
        $.each(images, function(index, image) {
          image.attr('data-image', index);
          preview.append(image);
        })
        dropzone.css({
          'width': `calc(100% - (20% * ${images.length}))`
        })
      }
      
    // imagesが１０枚になったら枠を消す
    if(images.length == 10) {
      dropzone2.css({
        'display': 'none'
      })
      return;
    }

    var new_image = $(`<input multiple= "multiple" name="item_images[image][]" class="upload-image" data-image= ${images.length} type="file" id="upload-image">`);
    input_area.prepend(new_image);
  });



  // 削除ボタン
  // $(document).on('click', '.delete', function() {
  //   var target_image = $(this).parent().parent();
  //   $.each(inputs, function(index, input){
  //     if ($(this).data('image') == target_image.data('image')){
  //       $(this).remove();
  //       target_image.remove();
  //       var num = $(this).data('image');
  //       images.splice(num, 1);
  //       inputs.splice(num, 1);
  //       if(inputs.length == 0) {
  //         $('input[type= "file"].upload-image').attr({
  //           'data-image': 0
  //         })
  //       }
  //     }
  //   })

  //   $('input[type= "file"].upload-image:first').attr({
  //     'data-image': inputs.length
  //   })
  //   $.each(inputs, function(index, input) {
  //     var input = $(this)
  //     input.attr({
  //       'data-image': index
  //     })
  //     $('input[type= "file"].upload-image:first').after(input)
  //   })
  //   if (images.length >= 5) {
  //     dropzone2.css({
  //       'display': 'block'
  //     })
  //     $.each(images, function(index, image) {
  //       image.attr('data-image', index);
  //       preview2.append(image);
  //     })
  //     dropzone2.css({
  //       'width': `calc(100% - (135px * ${images.length - 5}))`
  //     })
  //     if(images.length == 9) {
  //       dropzone2.find('p').replaceWith('<i class="fa fa-camera"></i>')
  //     }
  //     if(images.length == 8) {
  //       dropzone2.find('i').replaceWith('<p>ココをクリックしてください</p>')
  //     }
  //   } else {
  //     dropzone.css({
  //       'display': 'block'
  //     })
  //     $.each(images, function(index, image) {
  //       image.attr('data-image', index);
  //       preview.append(image);
  //     })
  //     dropzone.css({
  //       'width': `calc(100% - (135px * ${images.length}))`
  //     })
  //   }
  //   if(images.length == 4) {
  //     dropzone2.css({
  //       'display': 'none'
  //     })
  //   }
  //   if(images.length == 3) {
  //     dropzone.find('i').replaceWith('<p>ココをクリックしてください</p>')
  //   }
  // })
});
