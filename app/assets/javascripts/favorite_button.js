$(document).on('turbolinks:load', ()=> {

  // *** 手動設定変数 ***

  // 共通
  const areaWithButton = '.ItemProfile__favorite'
  const item_id = $('.FavoriteButton').data('index');
  const button = '.FavoriteButton';
  // 登録
  const bookmark = '.BookmarkFavoriteButton';
  const bookmarkUrl = '/items/bookmark';
  const deleteButton = `<div class="FavoriteButton DeleteFavoriteButton" data-index="14">★登録済み</div>`;
  // 登録解除
  const deleteBookmark = '.DeleteFavoriteButton';
  const deleteUrl = '/items/delete_bookmark';
  const bookmarkButton = `<div class="FavoriteButton BookmarkFavoriteButton" data-index="14">☆お気に入り</div>`;

  // *** イベント ***

  // お気に入り登録ボタンが押された時
  $(document).on('click', bookmark, function(){
    $.ajax({
      url: bookmarkUrl,
      type: 'GET',
      data: { item_id: item_id },
      dataType: 'json'
    })
    .done(function(){
      $(button).removeClass(bookmark.slice(1));
      $(button).addClass(deleteBookmark.slice(1));
    })
    .fail(function(){
      alert('お気に入り登録に失敗しました');
    })
  })

  // 登録解除ボタンが押された時
  $(document).on('click', deleteBookmark, function(){
    console.log('発火しました');
    $.ajax({
      url: deleteUrl,
      type: 'GET',
      data: { item_id: item_id },
      dataType: 'json'
    })
    .done(function(){
      $(button).removeClass(deleteBookmark.slice(1));
      $(button).addClass(bookmark.slice(1));
    })
    .fail(function(){
      alert('お気に入り登録解除に失敗しました');
    })
  })
})
