$(function(){
  // *** 変数 ***
  let Area = $('.ViewImageArea'); // 背景
  let Image = $('.ViewImage'); // 画像

  let area_a = 0; // rgbaのa
  let image_size = 0; // 拡大表示の画像サイズ
  let repeat_num = 20; // 各メソッドの繰り返し数
  var now_event = false; // イベント発火中に他のイベント発火を防止する


  // *** メソッド ***

  // 背景の出現
  function back_ground_display(area_a){
    area_a += (0.4 / repeat_num);
    Area.css('background-color', 'rgba(0, 0, 0, ' + area_a + ')');
    return area_a;
  };
  // 画像の出現
  function view_image_size(image_size){
    image_size += (700 / repeat_num);
    Image.css('max-height', image_size + 'px');
    Image.css('max-width', image_size + 'px');
    return image_size;
  };

  // 背景の消滅
  function back_ground_display_return(area_a){
    area_a -= (0.4 / repeat_num);
    Area.css('background-color', 'rgba(0, 0, 0, ' + area_a + ')');
    return area_a;
  };

  // 画像の縮小
  function view_image_size_return(image_size){
    image_size -= (700 / repeat_num);
    Image.css('max-height', image_size + 'px');
    Image.css('max-width', image_size + 'px');
    return image_size;
  };

  // *** イベント処理 ***

  // 画像の出現イベント

  $('.SelectedImage').on('click', function(){
    if(now_event == false) {
      now_event = true;
      Area.css('display', 'block');
      var appear = setInterval(() => {
        if(area_a < 0.4) {
          area_a = back_ground_display(area_a);
          image_size = view_image_size(image_size);
        } else {
          clearInterval(appear);
          now_event = false;
        }
      }, 10);
    }
  });

  // 画像が縮小するイベント
  $('.ViewImageArea').on('click', function(){
    if(now_event == false) {
      now_event = true;
      var disappear = setInterval(() => {
        if(area_a > 0) {
          area_a = back_ground_display_return(area_a);
          image_size = view_image_size_return(image_size);
        } else {
          clearInterval(disappear);
          Area.css('display', 'none');
          now_event = false;
        }
      }, 10);
    }
  });
});
