String textLenCheck(String text) {
  var arr = text.split(' ');

  if (arr.length > 4) {
    text = arr.sublist(0, 4).join(' ');
  } else {
    text = arr.join(' ');
  }
  return text;
}
