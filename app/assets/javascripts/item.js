// サムネイルスライダー

$(function () {
  var slider = "#slider";
  var thumbnailItem = "#thumb .item_s-img";

  $(thumbnailItem).each(function () {
    var index = $(thumbnailItem).index(this);
    $(this).attr("data-index", index);
  });

  // スライダー初期化後、カレントのサムネイル画像にクラス「thumbnail-current」を付ける
  // 「slickスライダー作成」の前にこの記述書く。
  $(slider).on('init', function (slick) {
    var index = $(".slide-item.slick-slide.slick-current").attr("data-slick-index");
    $(thumbnailItem + '[data-index="' + index + '"]').addClass("thumbnail-current");
  });

  //slickスライダー初期化
  $(slider).slick({
    autoplay: false,
    arrows: false,
  });
  //サムネイル画像アイテムをクリックしたときにスライダー切り替え
  $(thumbnailItem).on('mouseover', function () {
    var index = $(this).attr("data-index");
    $(slider).slick("slickGoTo", index, false);
  });

  //サムネイル画像のカレントを切り替え
  $(slider).on('beforeChange', function (event, slick, currentSlide, nextSlide) {
    $(thumbnailItem).each(function () {
      $(this).removeClass("thumbnail-current");
    });
    $(thumbnailItem + '[data-index="' + nextSlide + '"]').addClass("thumbnail-current");
  });

  //サムネイル画像の透明度
  $(".item_s-img").fadeTo(0, 0.5); // 初期値：透明度30%
  $(".item_s-img").hover(
    function () {
      $(this).stop().fadeTo("4000", 1.0); // マウスオーバーで透明度を100%にする
    },
    function () {
      $(this).stop().fadeTo("4000", 0.5); // マウスアウトで透明度を30%に戻す
    }
  );
});