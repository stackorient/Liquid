String textCapitalize(String text) {
  return text
      .split(" ")
      .map((word) =>
          word.length > 0 ? word[0].toUpperCase() + word.substring(1) : word)
      .join(" ");
}
