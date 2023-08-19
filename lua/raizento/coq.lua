status, coq = pcall(require, "coq")

if not status then
  print("Coq not found!")
  return
end
