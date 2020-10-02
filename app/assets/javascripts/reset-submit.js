$(function(){ // 新規登録画面の送信ボタンを再度押下可能にする
  let submit_button = $('.CreateAccountButton');

  submit_button.on('click', function(){
    $.ajax({
    }).done(function(){
      $('.CreateAccountButton').prop('disabled', false);
    }).fail(function(){
    })
  });
});