$(function() {
  var firstSelecthtml = `<option value="---">---</option>`;
  function foamHtml(search_result) {
    var html = `<option value="${search_result.id}">${
      search_result.name
    }</option>`;
    return html;
  }
  // $(".root-of-delivery_type-for-css").css("display", "none");
  $(".item__detail__form_box__size").css("display", "none");
  $(".child_id")
    .parent()
    .css("display", "none");
  $(".grandchild_id")
    .parent()
    .css("display", "none");

  $(".parent_id").change(function() {
    var parent_id = $(".parent_id").val();
    if (parent_id === "---") {
      $(".child_id")
        .parent()
        .css("display", "none");
      $(".grandchild_id")
        .parent()
        .css("display", "none");
    } else {
      console.log(parent_id);
      $.ajax({
        type: "GET",
        url: "/items/search_category",
        data: { parent_id: parent_id },
        dataType: "json"
      }).done(function(child_ids) {
        $(".child_id").empty();
        $(".child_id")
          .parent()
          .css("display", "");
        if (child_ids !== 1) {
          $(".child_id").append(firstSelecthtml);
          child_ids.forEach(function(child) {
            var html = foamHtml(child);
            $(".child_id").append(html);
          });
        } else {
          appendErrMsgToHTML("一致する映画はありません");
        }
      });
    }
  });

  $(".child_id").change(function() {
    // var input = $(".search__query").val();
    var parent_id = $(".child_id").val();
    console.log(parent_id);
    if (parent_id === "---") {
      $(".grandchild_id")
        .parent()
        .css("display", "none");
      $(".item__detail__form_box__size").css("display", "none");
    } else {
      $.ajax({
        type: "GET",
        url: "/items/search_category",
        data: { parent_id: parent_id },
        dataType: "json"
      }).done(function(child_ids) {
        $(".grandchild_id").empty();
        $(".grandchild_id").append(firstSelecthtml);
        $(".grandchild_id")
          .parent()
          .css("display", "");
        console.log(child_ids.length);
        if (child_ids.length == 1) {
          $(".grandchild").empty();
          $(".grandchild_id")
            .parent()
            .css("display", "none");
        }
        child_ids.forEach(function(child) {
          var html = foamHtml(child);
          $(".grandchild_id").append(html);
        });
      });
    }
  });

  $(".grandchild_id").change(function() {
    // var input = $(".search__query").val();
    var parent_id = $(".grandchild_id").val();
    console.log(parent_id);
    if (parent_id === "---") {
      $(".size_id").empty();
      $(".size_id").append(firstSelecthtml);
    } else {
      $.ajax({
        type: "GET",
        url: "/items/search_category",
        data: { parent_id: parent_id },
        dataType: "json"
      }).done(function(size_ids) {
        $(".size_id").empty();
        $(".size_id").append(firstSelecthtml);
        $(".item__detail__form_box__size").css("display", "");
        // size_idsが１の時はサイズがない時なので場合分け
        if (size_ids.length == 1) {
          $(".size_id").empty();
          $(".item__detail__form_box__size").css("display", "none");
        }
        size_ids.forEach(function(size) {
          var html = foamHtml(size);
          $(".size_id").append(html);
        });
      });
    }
  });

  $("#item_delivery_fee_payer").change(function() {
    var fee_payer = $("#item_delivery_fee_payer").val();
    $("#item_delivery_type").empty();
    $("#item_delivery_type").append(firstSelecthtml);
    if (fee_payer == "---") {
      $(".root-of-delivery_type-for-css").attr(
        "style",
        "display: none !important;"
      );
    } else if (fee_payer == "送料込み（出品者負担）") {
      $(".root-of-delivery_type-for-css").css("display", "");
      $("#item_delivery_type").append(
        ' <option value="未定">未定</option>\
      <option value="らくらくメルカリ便">らくらくメルカリ便</option>\
      <option value="ゆうメール">ゆうメール</option>\
      <option value="レターパック">レターパック</option>\
      <option value="普通郵便(定形、定形外)">普通郵便(定形、定形外)</option>\
      <option value="クロネコヤマト">クロネコヤマト</option>\
      <option value="ゆうパック">ゆうパック</option>\
      <option value="クリックポスト">クリックポスト</option>\
      <option value="ゆうパケット">ゆうパケット</option>'
      );
    } else if (fee_payer == "着払い（購入者負担）") {
      $(".root-of-delivery_type-for-css").css("display", "");
      $("#item_delivery_type").append(
        ' <option value="未定">未定</option>\
      <option value="クロネコヤマト">クロネコヤマト</option>\
      <option value="ゆうパック">ゆうパック</option>\
      <option value="ゆうメール">ゆうメール</option>\
      <option value="ゆうパック">ゆうパック</option>'
      );
    }
  });

  $(".sell-price__text_area_2").on("keyup", function() {
    var input = $(".sell-price__text_area_2").val();

    var fee = parseInt(input / 10);
    console.log(fee);
    if (isNaN(fee) == false && input >= 300 && input <= 9999999) {
      $(".mercari-share").val(fee);
      $(".seller-share").val(input - fee);
    } else {
      $(".mercari-share").val("-");
      $(".seller-share").val("-");
    }
  });
});
