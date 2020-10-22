$(document).on('turbolinks:load', ()=> {
  // カテゴリーセレクトボックスのオプションを作成
  function appendOption(category){
    var html = `<option value="${category.id}" data-category="${category.id}">${category.name}</option>`;
    return html;
  }
  // 子カテゴリーの表示作成
  function appendChildrenBox(insertHTML){
    var childSelectHtml = '';
    childSelectHtml = `<div class='categoryChoice__added' id= 'children_wrapper'>
                        <div class='categoryChoice__form'>
                          <select class='selectBoxBtn__form' id='child_category' name='item[category_id]'>
                            <option value='---' data-category='---'>選択してください</option>
                            ${insertHTML}
                          <select>
                        </div>
                      </div>`;
    $('.categoryChoice').append(childSelectHtml);
  }

  // 孫カテゴリーの表示作成
  function appendGrandchildrenBox(insertHTML){
    var grandchildSelectHtml = '';
    grandchildSelectHtml = `<div class='categoryChoice__added' id= 'grandchildren_wrapper'>
                             <div class='categoryChoice__form'>
                               <select class='selectBoxBtn__form' id='grandchild_category' name='item[category_id]'>
                                 <option value='---' data-category='---'>選択してください</option>
                                 ${insertHTML}
                               <select>
                             </div>
                           </div>`;
    $('.categoryChoice').append(grandchildSelectHtml);
  }

  // デフォルトメッセージ
    defaultText = '選択してください'

  // 親カテゴリー選択後のイベント
  $('#parent_category').on('change', function(){
    //選択された親カテゴリーの名前を取得
    var parentCategoryId = document.getElementById ('parent_category').value;
    var parentText = $('#parent_category option:selected').text();
    if (parentText != defaultText){//親カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/items/get_category_children',
        type: 'GET',
        data: { parent_id: parentCategoryId },
        dataType: 'json'
      })
      .done(function(children){
        $('#children_wrapper').remove(); //親が変更された時、子以下を削除する
        $('#grandchildren_wrapper').remove();
        var insertHTML = '';
        children.forEach(function(child){
          insertHTML += appendOption(child);
        });
        appendChildrenBox(insertHTML);
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#children_wrapper').remove(); //親カテゴリーが初期値になった時、子以下を削除する
      $('#grandchildren_wrapper').remove();
    }
  });

  // 子カテゴリー選択後のイベント
  $('.itemDetail__category').on('change', '#child_category', function(){
    var childCategoryId = document.getElementById ('child_category').value; //選択された子カテゴリーのidを取得
    var childText = $('#child_category option:selected').text();
    if (childText != defaultText){ //子カテゴリーが初期値でないことを確認
      $.ajax({
        url: '/items/get_category_grandchildren',
        type: 'GET',
        data: { child_id: childCategoryId },
        dataType: 'json'
      })
      .done(function(grandchildren){
        if (grandchildren.length != 0) {
          $('#grandchildren_wrapper').remove();//子が変更された時、孫以下を削除する
          var insertHTML = '';
          grandchildren.forEach(function(grandchild){
            insertHTML += appendOption(grandchild);
            
          });
          appendGrandchildrenBox(insertHTML);
          
        }
      })
      .fail(function(){
        alert('カテゴリー取得に失敗しました');
      })
    }else{
      $('#grandchildren_wrapper').remove(); //子カテゴリーが初期値になった時、孫以下を削除する
    }
  });
});