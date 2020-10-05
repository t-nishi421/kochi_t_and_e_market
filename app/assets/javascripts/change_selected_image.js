$(function(){
  $('.ListImage').on('click', function(){
    // 選択した画像を取得
    var image = $(this).attr('src');

    // 選択した画像に変更
    $('.SelectedImage').attr('src', image);
    $('.ViewImage').attr('src', image);

    $('.ListImage').removeClass("Selected");
    $(this).addClass("Selected");
  })
});
