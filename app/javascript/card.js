document.addEventListener('turbolinks:load', function () {
  if (!$('#creditCard__form')[0]) return false; //カード登録ページではないなら以降実行しない。
  console.log("card");
});