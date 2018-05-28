require_relative 'sliders/queen'
require_relative 'sliders/bishop'
require_relative 'sliders/rook'

if __FILE__ == $PROGRAM_NAME
  q = Queen.new(:black, [0,4])
  b = Bishop.new(:black, [0,2])
  r = Rook.new(:black, [0,0])

  p q

  q.move([7,4]) # good pos
  p q.current_pos === [7, 4]
  q.move([3,3]) # bad pos, shouldn't update
  p q.current_pos === [7, 4]
  p "---"
  b.move([1,3]) # good pos
  p b.current_pos === [1, 3]
  b.move([0,0]) # bad pos, shouldn't update
  p b.current_pos === [1, 3]
  p "---"
  r.move([7,0]) # good pos
  p r.current_pos === [7,0]
  r.move([3,3]) # bad pos, shouldn't update
  p r.current_pos === [7,0]
end
