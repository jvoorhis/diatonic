require 'rational'

module Math
  unless defined?(log2)
    LOG2 = Math.log(2)
    
    module_function
    def log2(x)
      Math.log(x) / LOG2
    end
  end
end  

class Numeric
  def sgn
    if zero? then 0
    elsif self > 0 then 1
    else -1 end
  end
end

module Kernel
  # Convert midi note numbers to hertz.
  def mtof(pitch)
    440.0 * (2.0 ** ((pitch.to_f-69)/12))
  end
  
  # Convert hertz to midi note numbers.
  def ftom(pitch)
    (69 + 12 * (Math.log2(pitch / 440.0))).round
  end
end
