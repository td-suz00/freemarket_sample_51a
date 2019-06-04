document.addEventListener(
  "DOMContentLoaded", e => {
    if (document.getElementById("token_submit") != null) {
      //token_submitというidがnullの場合、下記コードを実行しない
      Payjp.setPublicKey("pk_test_6030158c73593f6405f71fe5"); //公開鍵
      let btn = document.getElementById("token_submit");
      btn.addEventListener("click", e => {
        e.preventDefault();
        let card = {
          number: document.getElementById("card_number").value,
          cvc: document.getElementById("cvc").value,
          exp_month: document.getElementById("exp_month").value,
          exp_year: document.getElementById("exp_year").value
        }; //入力されたデータを取得
        Payjp.createToken(card, (status, response) => {
          if (status === 200) {
            //トーク生成に成功した場合
            $("#card_number").removeAttr("name"); //データを自サーバにpostしないように削除
            $("#cvc").removeAttr("name");
            $("#exp_month").removeAttr("name");
            $("#exp_year").removeAttr("name");
            $("#card_token").append(
              $('<input type="hidden" name="payjp-token">').val(response.id)
            );
            //取得したトークンを送信できる状態にする
            document.inputForm.submit();
alert("登録が完了しました"); //確認用
          } else {
alert("カード情報が正しくありません。"); //確認用
          }
        });
      });
    }
  },
  false
);