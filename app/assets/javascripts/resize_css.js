$(document).on('turbolinks:load', ()=> {

  // 【マイページ】サイドバーのリサイズ
  $(window).on('load resize', function(){
    const main = '.myPage__sidebar';
    const pair = '.myPage__main';
    const initialSize = '300px';

    var winW = $(window).width();
    var devW = 1150;
    var pairW = $(pair).width();
    if (winW <= devW) {
      //devWpx以下の時の処理
      $(main).css('max-width', pairW);
      $(main).css('min-width', pairW);
    } else {
      //devWpxより大きい時の処理
      $(main).css('max-width', initialSize);
      $(main).css('min-width', initialSize);
    }
  });

  // 【商品詳細】商品詳細欄のリサイズ
  $(window).on('load resize', function(){
    const main = '.CommentForm__textArea';
    const pair = '.CommentForm__button';
    const sub = '.ItemProfile__status';
    const initialSize = '620px';

    var winW = $(window).width();
    var devW = 700;
    var pairW = $(pair).width();
    if (winW <= devW) {
      //devWpx以下の時の処理
      $(main).css('max-width', pairW);
      $(main).css('min-width', pairW);
      $(sub).css('display', 'block');
      console.log('小');
    } else {
      //devWpxより大きい時の処理
      $(main).css('max-width', initialSize);
      $(main).css('min-width', initialSize);
      $(sub).css('display', 'flex');
      console.log('大');
    }
  });
})
