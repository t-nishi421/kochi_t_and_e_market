$(document).on('turbolinks:load', ()=> {

  // *** 手動設定変数 ***

  // 共通
  const item_id = $('.FavoriteButton').data('index');
  const button = '.FavoriteButton';
  // 登録
  const bookmark = '.BookmarkFavoriteButton';
  const bookmarkUrl = '/items/bookmark';
  const deleteText = '★登録済み';
  const bookmarkAlert = 'お気に入り登録に失敗しました';
  // 登録解除
  const deleteBookmark = '.DeleteFavoriteButton';
  const deleteUrl = '/items/delete_bookmark';
  const bookmarkText = '☆お気に入り';
  const deleteAlert = 'お気に入り登録解除に失敗しました';

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
      $(button).text(deleteText);
    })
    .fail(function(){
      alert(bookmarkAlert);
    })
  })

  // 登録解除ボタンが押された時
  $(document).on('click', deleteBookmark, function(){
    $.ajax({
      url: deleteUrl,
      type: 'GET',
      data: { item_id: item_id },
      dataType: 'json'
    })
    .done(function(){
      $(button).removeClass(deleteBookmark.slice(1));
      $(button).addClass(bookmark.slice(1));
      $(button).text(bookmarkText);
    })
    .fail(function(){
      alert(deleteAlert);
    })
  })
})
