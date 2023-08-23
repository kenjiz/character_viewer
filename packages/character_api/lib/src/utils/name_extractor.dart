class NameExtractor {
  const NameExtractor._();

  /// Utility tools that extract the name from DuckDuckGo API
  /// that can be found inside the 'Result' key enclosed within a tag
  static String extract(String input) {
    int startIdx = input.indexOf("<a");
    int endIdx = input.indexOf("</a>");

    if (startIdx != -1 && endIdx != -1) {
      String anchorContent = input.substring(startIdx, endIdx);
      int openingBracketIdx = anchorContent.indexOf(">");
      if (openingBracketIdx != -1) {
        return anchorContent.substring(openingBracketIdx + 1);
      }
    }

    return "";
  }
}
