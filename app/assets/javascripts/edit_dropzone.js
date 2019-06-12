$(window).on("load", function() {
  var dropzone = $(".item__img__dropzone__input");
  var dropzone2 = $(".item__img__dropzone2__input2");
  var appendzone = $(".item__img__dropzone2")
  var images = [];
  // var inputs = [];
  var input_area = $(".input-area");
  var preview = $("#preview");
  var preview2 = $("#preview2");

  gon.item_images.forEach(function(image){

    var img = $(`<div class= "add_img"><div class="img_area"><div class=image><img width="100%", height="100%"></div</div></div>`);

    var btn_wrapper = $('<div class="btn_wrapper"><a class="btn_edit">編集</a><a class="btn_delete">削除</a></div>');

    img.append(btn_wrapper);

    var reader = new FileReader();

    console.log(reader)

    reader.onload = function(e) {
      // 画像に編集・削除ボタンをつける
      img.append(btn_wrapper);
      img.find("img").attr({
        src: e.target.result
      });
      console.log(e.target.result)
    };

    images.push(img)
  })

  console.log(images)

  // 画像が４枚以下のとき
  if (images.length <= 4) {
    $('#preview').empty();
    $.each(images, function(index, image) {
      image.data('image', index);
      preview.append(image);
    })
    dropzone.css({
      'width': `calc(100% - (20% * ${images.length}))`
    })

    // 画像が５枚のとき１段目の枠を消し、２段目の枠を出す
  } else if (images.length == 5) {
    $("#preview").empty();
    $.each(images, function(index, image) {
      image.data("image", index);
      preview.append(image);
    });
    appendzone.css({
      display: "block"
    });
    dropzone.css({
      display: "none"
    });
    preview2.empty();

    // 画像が６枚以上のとき
  } else if (images.length >= 6) {
    // 配列から６枚目以降の画像を抽出
    var pickup_images = images.slice(5);

    $.each(pickup_images, function(index, image) {
      image.data("image", index + 5);
      preview2.append(image);
      dropzone2.css({
        width: `calc(100% - (20% * ${images.length - 5}))`
      });
    });

    // 画像が１０枚になったら枠を消す
    if (images.length == 10) {
      dropzone2.css({
        display: "none"
      });
    }
  }

  var new_image = $(
    `<input multiple= "multiple" name="item_images[image][]" class="upload-image" data-image= ${images.length} type="file" id="upload-image">`
  );
  input_area.append(new_image);

  // dropzone.css({
  //   'width': `calc(100% - (20% * ${images.length}))`
  // })

  $(".edit_item .item__img__dropzone, .item__img__dropzone2").on("change", 'input[type= "file"].upload-image', function() {
    var file = $(this).prop("files")[0];
    var reader = new FileReader();
    // inputs.push($(this));
    var img = $(`<div class= "add_img"><div class="img_area"><div class=image><img width="100%", height="100%"></div</div></div>`);

    reader.onload = function(e) {
      var btn_wrapper = $('<div class="btn_wrapper"><a class="btn_edit">編集</a><a class="btn_delete">削除</a></div>');

      // 画像に編集・削除ボタンをつける
      img.append(btn_wrapper);
      img.find("img").attr({
        src: e.target.result
      });
    };

    reader.readAsDataURL(file);
    images.push(img);

    // console.log(images)

    // 画像が４枚以下のとき
    if (images.length <= 4) {
      $('#preview').empty();
      $.each(images, function(index, image) {
        image.data('image', index);
        preview.append(image);
      })
      dropzone.css({
        'width': `calc(100% - (20% * ${images.length}))`
      })

      // 画像が５枚のとき１段目の枠を消し、２段目の枠を出す
    } else if (images.length == 5) {
      $("#preview").empty();
      $.each(images, function(index, image) {
        image.data("image", index);
        preview.append(image);
      });
      appendzone.css({
        display: "block"
      });
      dropzone.css({
        display: "none"
      });
      preview2.empty();

      // 画像が６枚以上のとき
    } else if (images.length >= 6) {
      // 配列から６枚目以降の画像を抽出
      var pickup_images = images.slice(5);

      $.each(pickup_images, function(index, image) {
        image.data("image", index + 5);
        preview2.append(image);
        dropzone2.css({
          width: `calc(100% - (20% * ${images.length - 5}))`
        });
      });

      // 画像が１０枚になったら枠を消す
      if (images.length == 10) {
        dropzone2.css({
          display: "none"
        });
      }
    }

    var new_image = $(
      `<input multiple= "multiple" name="item_images[image][]" class="upload-image" data-image= ${images.length} type="file" id="upload-image">`
    );
    input_area.append(new_image);
  });
});


