$(function() {
  var firstSelecthtml = `<option value="---">---</option>`;
  function foamHtml(search_result) {
    var html = `<option value="${search_result.id}">${
      search_result.name
    }</option>`;
    return html;
  }

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
        if (child_ids.length == 1) {
          $(".grandchild").empty();
          $(".child_id")
            .parent()
            .css("display", "");
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
});
