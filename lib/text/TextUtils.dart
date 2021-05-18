import 'dart:math' as Math;
// import 'dart:html' as html;

// String _parseHtmlString(String htmlString) {
//   var text = html.Element.span()..appendHtml(htmlString);
//   return text.innerText;
// }

class TextUtils {
  static const SAFE_STRING_FLAG_TRIM = 1;

  static const SAFE_STRING_FLAG_SINGLE_LINE = 2;
  static const SAFE_STRING_FLAG_FIRST_LINE = 4;

  static bool _isNewline(int codePoint) {
    var text = String.fromCharCode(codePoint);
    return text == "\\n" || text == "\\r\\n";
  }

  static bool _isWhiteSpace(int codePoint) {
    var text = String.fromCharCode(codePoint);
    return text == " " || text == "\\s";
  }

  static String makeSafeForPresentation(String unclean,
      int maxCharactersToConsider, double ellipsizeDip, int flags) {
    bool onlyKeepFirstLine = ((flags & SAFE_STRING_FLAG_FIRST_LINE) != 0);
    bool forceSingleLine = ((flags & SAFE_STRING_FLAG_SINGLE_LINE) != 0);
    bool trim = ((flags & SAFE_STRING_FLAG_TRIM) != 0);

    String shortString;

    if (maxCharactersToConsider > 0) {
      shortString = unclean.substring(
          0, Math.min(unclean.length, maxCharactersToConsider));
    } else {
      shortString = unclean;
    }

    // Treat string as HTML. This
    // - converts HTML symbols: e.g. &szlig; -> ß
    // - applies some HTML tags: e.g. <br> -> \n
    // - removes invalid characters such as \b
    // - removes html styling, such as <b>
    // - applies html formatting: e.g. a<p>b</p>c -> a\n\nb\n\nc
    // - replaces some html tags by "object replacement" markers: <img> -> \ufffc
    // - Removes leading white space
    // - Removes all trailing white space beside a single space
    // - Collapses double white space
    _StringWithRemovedChars gettingCleaned =
        _StringWithRemovedChars((shortString));
    int firstNonWhiteSpace = -1;
    int firstTrailingWhiteSpace = -1;

    // Remove new lines (if requested) and control characters.
    int uncleanLength = gettingCleaned.length();
    for (int offset = 0; offset < uncleanLength;) {
      int codePoint = gettingCleaned.codePointAt(offset);
      // int type = String.fromCharCode(codePoint);
      int codePointLen = String.fromCharCode(codePoint).length;
      bool isNewline = _isNewline(codePoint);
      if (onlyKeepFirstLine && isNewline) {
        gettingCleaned.removeAllCharAfter(offset);
        break;
      } else if (forceSingleLine && isNewline) {
        gettingCleaned.removeRange(offset, offset + codePointLen);
      }
      // else if (type == Character.CONTROL && !isNewline) {
      //   gettingCleaned.removeRange(offset, offset + codePointLen);
      // }
      else if (trim && !_isWhiteSpace(codePoint)) {
        // This is only executed if the code point is not removed
        if (firstNonWhiteSpace == -1) {
          firstNonWhiteSpace = offset;
        }
        firstTrailingWhiteSpace = offset + codePointLen;
      }
      offset += codePointLen;
    }

    if (trim) {
      // Remove leading and trailing white space
      if (firstNonWhiteSpace == -1) {
        // No non whitespace found, remove all
        gettingCleaned.removeAllCharAfter(0);
      } else {
        if (firstNonWhiteSpace > 0) {
          gettingCleaned.removeAllCharBefore(firstNonWhiteSpace);
        }
        if (firstTrailingWhiteSpace < uncleanLength) {
          gettingCleaned.removeAllCharAfter(firstTrailingWhiteSpace);
        }
      }
    }

    return gettingCleaned.toString();
  }
}

class _StringWithRemovedChars {
  /** The original string */
  final String mOriginal;
  Map<int, int> mRemovedChars = Map();

  _StringWithRemovedChars(this.mOriginal);

  /**
         * Mark all chars in a range {@code [firstRemoved - firstNonRemoved[} (not including
         * firstNonRemoved) as removed.
         */
  void removeRange(int firstRemoved, int firstNonRemoved) {
    mRemovedChars[firstRemoved] = firstNonRemoved;
  }

  /**
         * Remove all characters before {@code firstNonRemoved}.
         */
  void removeAllCharBefore(int firstNonRemoved) {
    mRemovedChars[0] = firstNonRemoved;
  }

  /**
         * Remove all characters after and including {@code firstRemoved}.
         */
  void removeAllCharAfter(int firstRemoved) {
    mRemovedChars[firstRemoved] = mOriginal.length;
  }

  String toString() {
    // Common case, no chars removed
    if (mRemovedChars == null) {
      return mOriginal;
    }
    String sb = "";
    for (int i = 0; i < mOriginal.length; i++) {
      if (!mRemovedChars.containsKey(i)) {
        sb += (mOriginal[i]);
      }
    }
    return sb.toString();
  }

  /**
         * Return length or the original string
         */
  int length() {
    return mOriginal.length;
  }

  /**
         * Return codePoint of original string at a certain {@code offset}
         */
  int codePointAt(int offset) {
    return mOriginal.codeUnitAt(offset);
  }
}
