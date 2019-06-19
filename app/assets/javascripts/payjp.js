document.addEventListener("turbolinks:load", function() {
  $(function() {
    var form = $("#charge-form");
    Payjp.setPublicKey(gon.payjp_test_pk);
    $(document).on("click", "#token_submit", function(e) {
      e.preventDefault();
      var card = {
          number: $("#card_number").val(),
          cvc: $("#cvc").val(),
          exp_month: $("#exp_month_updated_at_2i").val(),
          exp_year: 20 + $("#exp_year").val(),
      };
      Payjp.createToken(card, function(s, response) {
        if (response.error) {
          alert('カード情報が正しくありません');
          $("#token_submit").prop("disabled", false);
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
});