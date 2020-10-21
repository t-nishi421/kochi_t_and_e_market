$(document).on('turbolinks:load', ()=> {

// 【マイページ】サイドバーのリサイズ
$(window).on('load resize', function(){
  const main = '.myPage__sidebar';
  const pair = '.myPage__main';
  const sub = '.myPage';
  const initialSize = '300px';
  const initialMargin = '30px 0 30px 5vw';
  const pairMaxW = $(pair).css('max-width');
  const pairMinW = $(pair).css('min-width');
  
  var winW = $(window).width();
  var devW = 1000;
  if (winW <= devW) {
    //devWpx以下の時の処理
    $(main).css('max-width', pairMaxW);
    $(main).css('min-width', pairMinW);
    $(main).css('margin', '30px 5vw');
    $(sub).css('flex-wrap', 'wrap-reverse');
  } else {
    //devWpxより大きい時の処理
    $(main).css('max-width', initialSize);
    $(main).css('min-width', initialSize);
    $(main).css('margin', initialMargin);
    $(sub).css('flex-wrap', '');
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
    } else {
      //devWpxより大きい時の処理
      $(main).css('max-width', initialSize);
      $(main).css('min-width', initialSize);
      $(sub).css('display', 'flex');
    }
  });
})
