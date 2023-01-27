import re


def get_text(file):
    """Read text from file ..."""
    text = open(file).read()
    text = re.sub(r"<.*?>", " ", text)
    text = re.sub(r"\s+", " ", text)
    return text
