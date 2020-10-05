$(function(){
  // 変数
  let Area = $('.ViewImageArea');
  let Image = $('.ViewImage');

  let area_a = 0; // rgbaのa
  let image_size = 0; // 拡大表示の画像サイズ
  let repeat_num = 20; // 各メソッドの繰り返し数

  // メソッド
  function back_ground_display(area_a){
    area_a += (0.4 / repeat_num);
    Area.css('background-color', 'rgba(0, 0, 0, ' + area_a + ')');
    return area_a;
  };

  function back_ground_display_return(area_a){
    area_a -= (0.4 / repeat_num);
    Area.css('background-color', 'rgba(0, 0, 0, ' + area_a + ')');
    return area_a;
  };

  function view_image_size(image_size){
    image_size += (700 / repeat_num);
    Image.css('max-height', image_size + 'px');
    Image.css('max-width', image_size + 'px');
    return image_size;
  };

  function view_image_size_return(image_size){
    image_size -= (700 / repeat_num);
    Image.css('max-height', image_size + 'px');
    Image.css('max-width', image_size + 'px');
    return image_size;
  };

  // イベント処理
  // 画像の出現イベント
  $('.SelectedImage').on('click', function(){
    Area.css('display', 'block');
      var appear = setInterval(() => {
        if(area_a < 0.4) {
          area_a = back_ground_display(area_a);
          image_size = view_image_size(image_size);
        } else {
          clearInterval(appear);
        }
      }, 10);
  });

  // 画像が縮小するイベント
  $('.ViewImageArea').on('click', function(){
    var disappear = setInterval(() => {
      if(area_a > 0) {
        area_a = back_ground_display_return(area_a);
        image_size = view_image_size_return(image_size);
      } else {
        clearInterval(disappear);
        Area.css('display', 'none');
      }
    }, 10);
  });
});
