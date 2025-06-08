string.shorten = function(text, max_length, characters_to_shorten, char_to_use)
  if text:len() > max_length then
    return text:sub(1, max_length - characters_to_shorten) .. string.rep(char_to_use, characters_to_shorten)
  end

  return text
end

string.is_blank = function(text)
  return (text:len() == 0 or not text) and true or false
end
