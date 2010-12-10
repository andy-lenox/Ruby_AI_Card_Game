def longest_string(hand, last=nil, length=0)
  current = last
  if hand.delete(current)
    length+=1
    same = longest_string(hand,current, length) || 0
    less = longest_string(hand,current, length-1) || 0
    more = longest_string(hand,current, length+1) || 0
  else
    return [same, less, more].max 
  end
end

hand1 = [1,2,3,4,5]

puts "#{longest_string(hand1, 1)}"