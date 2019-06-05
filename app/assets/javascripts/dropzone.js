$(document).on('turbolinks:load', function(){
  var dropzone = $('.item__img__dropzone__input');
  var dropzone2 = $('.item__img__dropzone2__input2');
  var appendzone = $('.item__img__dropzone2')
  var images = [];
  var inputs  =[];
  var input_area = $('.input-area');
  var preview = $('#preview');
  var preview2 = $('#preview2');

  $(document).on('change', 'input[type= "file"].upload-image',function(event) {
    var file = $(this).prop('files')[0];
    var reader = new FileReader();
    inputs.push($(this));
    var img = $(`<div class= "add_img"><div class="img_area"><div class=image><img width="100%", height="100%"></div</div></div>`);

    reader.onload = function(e) {
      var btn_wrapper = $('<div class="btn_wrapper"><a class="btn_edit">編集</a><a class="btn_delete">削除</a></div>');

      // 画像に編集・削除ボタンをつける
      img.append(btn_wrapper);
      img.find('img').attr({
        src: e.target.result
      })
    }

    reader.readAsDataURL(file);
    images.push(img);

    // 画像が４枚以下のとき
    if(images.length <= 4) {
      $('#preview').empty();
      $.each(images, function(index, image) {
        image.attr('data-image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (20% * ${images.length}))`
      })

      // 画像が５枚のとき１段目の枠を消し、２段目の枠を出す
      } else if(images.length == 5) {
        $('#preview').empty();
        $.each(images, function(index, image) {
          image.attr('data-image', index);
          preview.append(image);
        })
        appendzone.css({
          'display': 'block'
        })
        dropzone.css({
          'display': 'none'
        })
        preview2.empty();

      // 画像が６枚以上のとき
      } else {
        // 配列から６枚目以降の画像を抽出
        var pickup_images = images.slice(5);

        $.each(pickup_images, function(index, image) {
          image.attr('data-image', index+5);
          preview2.append(image);
          dropzone2.css({
            'width': `calc(100% - (20% * ${images.length - 5}))`
          })
        })

        // 画像が１０枚になったら枠を消す
        if(images.length == 10) {
          dropzone2.css({
            'display': 'none'
          })
          return;
        }

      // var new_image = $(`<input multiple= "multiple" name="item_images[image][]" class="upload-image" data-image= ${images.length} type="file" id="upload-image">`);
      // input_area.prepend(new_image);
    }
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
