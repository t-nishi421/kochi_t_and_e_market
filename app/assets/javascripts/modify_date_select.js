$(function(){
  // 28,29,30,31日のselect要素
  let days28 =
  `<option value="1">1</option>
  <option value="2">2</option>
  <option value="3">3</option>
  <option value="4">4</option>
  <option value="5">5</option>
  <option value="6">6</option>
  <option value="7">7</option>
  <option value="8">8</option>
  <option value="9">9</option>
  <option value="10">10</option>
  <option value="11">11</option>
  <option value="12">12</option>
  <option value="13">13</option>
  <option value="14">14</option>
  <option value="15">15</option>
  <option value="16">16</option>
  <option value="17">17</option>
  <option value="18">18</option>
  <option value="19">19</option>
  <option value="20">20</option>
  <option value="21">21</option>
  <option value="22">22</option>
  <option value="23">23</option>
  <option value="24">24</option>
  <option value="25">25</option>
  <option value="26">26</option>
  <option value="27">27</option>
  <option value="28">28</option>`;
  let days29 = days28 + `
  <option value="29">29</option>`;
  let days30 = days29 + `
  <option value="30">30</option>`;
  let days31 = days30 + `
  <option value="31">31</option>`;

  // 初めに選択されている年月日を取得
  let year = $('#profile_birthday_1i').val();
  let month = $('#profile_birthday_2i').val();

  // うるう年の判定
  let leap_year = false;

  // ページが読み込まれた後に修正
  leap_year = check_leap_year(year);
  change_days(month, leap_year);

  $('#profile_birthday_1i').change(function() { // yearが選択された時
    year = $(this, 'option:selected').val();
    
    leap_year = check_leap_year(year);

    change_days(month, leap_year);
  });

  $('#profile_birthday_2i').change(function() { // monthが選択された時
    month = $(this, 'option:selected').val();

    change_days(month, leap_year);
  });

  function check_leap_year(year) { // うるう年の判定
    if( (year % 4 === 0 && year % 100 !== 0) || year % 400 === 0) {
      return true;
    } else {
      return false;
    };
  }

  function change_days(month, leap_year) { // 日にちの選択欄を変更
    $('#profile_birthday_3i').children().remove();
    if (month == 1 || month == 3 || month == 5 ||  month == 7 || month == 8 || month == 10 || month == 12) {
      $('#profile_birthday_3i').append(days31);
    } else if (month == 4 || month == 6 || month == 9 || month == 11) {
      $('#profile_birthday_3i').append(days30);
    } else {
      if (leap_year) {
        $('#profile_birthday_3i').append(days29);
      } else {
        $('#profile_birthday_3i').append(days28);
      }
    }
  }

});
