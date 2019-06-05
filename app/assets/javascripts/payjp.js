$(function() {
  var form = $("#charge-form");
  Payjp.setPublicKey('pk_test_6030158c73593f6405f71fe5');
// console.log(Payjp.getPublicKey());
  $(document).on("click", "#token_submit", function(e) {
    e.preventDefault();
    form.find("input[type=submit]").prop("disabled", true);
    var card = {
        number: $("#card_number").val(),
        cvc: $("#cvc").val(),
        exp_month: $("#exp_month_updated_at_2i").val(),
        exp_year: 20 + $("#exp_year").val(),
    };
// console.log(card);
    Payjp.createToken(card, function(s, response) {
      if (response.error) {
        alert('カード情報が正しくありません');
      }
      else {
        $("#card_number").removeAttr("name");
        $("#cvc").removeAttr("name");
        $("#exp_month_updated_at_1i").removeAttr("name");
        $("#exp_month_updated_at_2i").removeAttr("name");
        $("#exp_month_updated_at_3i").removeAttr("name");
        $("#exp_year").removeAttr("name");
        var token = response.id;
        form.append($('<input type="hidden" name="payjp_token">').val(token));
        form.get(0).submit();
      }
    });
  });
});



// $(function() {
//   document.addEventListener(
//   "DOMContentLoaded", e => {
// console.log(1);
//     if (document.getElementById("token_submit") != null) {
//       // token_submitというidがnullの場合、下記コードを実行しない
//       Payjp.setPublicKey("pk_test_6030158c73593f6405f71fe5"); //公開鍵
//       let btn = document.getElementById("token_submit");
//       btn.addEventListener("click", e => {
//         e.preventDefault();
//         let card = {
//           number: document.getElementById("card_number").value,
//           cvc: document.getElementById("cvc").value,
//           exp_month: document.getElementById("exp_month_updated_at_2i").value,
//           exp_year: "20" + document.getElementById("exp_year").value
//         }; //入力されたデータを取得
// console.log(card);
//         Payjp.createToken(card, (status, response) => {
//           if (status === 200) {
//             //トーク生成に成功した場合
//             $("#card_number").removeAttr("name"); //データを自サーバにpostしないように削除
//             $("#cvc").removeAttr("name");
//             $("#exp_month_updated_at_2i").removeAttr("name");
//             $("#exp_year").removeAttr("name");
//             $("#card_token").append(
//               $('<input type="hidden" name="payjp_token">').val(response.id)
//             );
//             //取得したトークンを送信できる状態にする
// console.log(response);
// console.log(response.id);
//             document.inputForm.submit();
// alert("登録が完了しました"); //確認用
//           } else {
// alert("カード情報が正しくありません。"); //確認用
//           }
//         });
//       });
//     }
//   },
//   false
// )
// });