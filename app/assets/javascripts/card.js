//= require turbolinks

document.addEventListener('turbolinks:load', function () {

  if (!$('#card__form')[0]) return false; //カード登録ページではないなら以降実行しない。

  //認証用のパブリックキー
  Payjp.setPublicKey("pk_test_2cb4f1afecbed4bf0fef611d");
  // 追加
  const registButton = $('#card__regist'); //カード入力フォームの登録ボタン
  registButton.on("click", function (e) { //登録ボタンを押したとき（ここはsubmitではなくclickにしておく）
    e.preventDefault();
    
    const card = {
      number: $('#card__num').val(),
      cvc: $('#card__cvc').val(),
      exp_month: $('#exp__month').val(),
      exp_year: $('#exp__year').val()
    };

    Payjp.createToken(card, (status, response) => { //cardをpayjpに送信して登録する。

      if (status === 200) { //成功した場合
        alert("カードを登録しました");
        $('#card__token').append(
          `<input type="hidden" name="payjp_token" value=${response.id}>`
        );
        // ↓formのsubmitボタンを強制起動する（ページが遷移してコントローラが起動する）。
        $('#card__num').removeAttr('name');
        $('#card__cvc').removeAttr('name');
        $('#exp__month').removeAttr('name');
        $('#exp__year').removeAttr('name');
        $('#card__form')[0].submit();
      } else { //失敗した場合
        alert("カード情報が正しくありません。");
        registButton.prop('disabled', false);
      }

    });
  });
});