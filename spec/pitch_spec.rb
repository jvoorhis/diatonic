require File.join( File.dirname(__FILE__), 'spec_helper')

describe Pitch do
  it "can be created from an integer" do
    Pitch.from_midi(0).should   == c_1
    Pitch.from_midi(69).should  == a4
    Pitch.from_midi(127).should == g9
  end
  
  it "can be created from frequency in hertz" do
    Pitch.from_hz(440.0).should  == a4
    Pitch.from_hz(261.62).should == c4
    Pitch.from_hz(220.0).should  == a3
  end
  
  it "has an ordering" do
    # Representative cases:
    { c4  => cs4, # Raised by a semitone
      cs4 => df4, # Enharmonics
      es4 => f4,
      c3  => c4,  # Across octaves
      bs3 => c4,
      cf4 => bs3
    }.each do |x,y|
      x.should < y
    end
  end
  
  it "results in a new Pitch when semitones are added" do
    (c4 + 1).should   == cs4
    (c4 + -1).should  == b3
    (c4 + 12).should  == c5
    (c4 + -12).should == c3
  end
  
  it "results in a new Pitch when semitones are subtracted" do
    (c4 - -1).should  == cs4
    (c4 - 1).should   == b3
    (c4 - -12).should == c5
    (c4 - 12).should  == c3
  end
  
  it "is scaled when multiplied" do
    (c4 * 2).should   == c5
    (c4 * 0.5).should == c3
  end
  
  it "is scaled when divided" do
    (c4 / 0.5).should == c5
    (c4 / 2).should   == c3
  end
  
  it "produces a ratio when compared with another Pitch" do
    (c4 % c5).should == 0.5
    (c5 % c4).should == 2.0
    
    (f_1 % c_1).should be_close(1.334840, 1e-6)
    (g_1 % c_1).should be_close(1.498307, 1e-6)
    
    (f4 % c4).should be_close(1.334840, 1e-6)
    (g4 % c4).should be_close(1.498307, 1e-6)
    
    (f9 % c9).should be_close(1.334840, 1e-6)
    (g9 % c9).should be_close(1.498307, 1e-6)
  end
  
  it "can be used as Hash keys" do
    c4.hash.should == c4.hash
  end
  
  it "returns the nearest Pitch of given PitchClass" do
    c4.nearest(b).should == b3
    c4.nearest(bs).should == bs3
    c4.nearest(c).should == c4
    c4.nearest(d).should == d4
  end
end

describe PitchClass do
  it "has a rank" do
    { c => 0,
      d => 2,
      e => 4,
      f => 5,
      g => 7,
      a => 9,
      b => 11 }.each do |pc, i|
      pc.rank.should == i
    end
  end
  
  it "has a natural rank" do
    [c,d,e,f,g,a,b].each do |pc|
      pc.natural_rank.should == pc.rank
    end
  end
  
  it "can be cast to an Integer" do
    [c,d,e,f,g,a,b].each do |pc|
      pc.to_i.should == pc.rank
    end
  end
  
  it "can be constructed from an Integer" do
    { 0  => c,
      1  => cs,
      2  => d,
      3  => ds,
      4  => e,
      5  => f,
      6  => fs,
      7  => g,
      8  => gs,
      9  => a,
      10 => as,
      11 => b }.each do |i, pc|
      PitchClass.from_integer(i).should == pc 
    end
  end
  
  it "can be constructed from an Integer >= 12" do
    PitchClass.from_integer(60).should == c
    PitchClass.from_integer(62).should == d
    # ...
    PitchClass.from_integer(71).should == b
  end
  
  it "has a String representation" do
    { c => 'C',
      d => 'D',
      e => 'E',
      f => 'F',
      g => 'G',
      a => 'A',
      b => 'B' }.each do |pc, s|
      pc.to_s.should == s
    end
  end
end

describe Sharp do
  it "is defined in terms of a natural PitchClass" do
    { cs => c,
      ds => d,
      es => e,
      fs => f,
      gs => g,
      as => a,
      bs => b }.each do |sharp, nat|
      sharp.should == nat.sharp
    end
  end
  
  it "has a rank" do
    { cs => c,
      ds => d,
      es => e,
      fs => f,
      gs => g,
      as => a,
      bs => b }.each do |sharp, nat|
      sharp.rank.should == nat.rank + 1
    end
  end
  
  it "has a natural rank" do
    { cs => c,
      ds => d,
      es => e,
      fs => f,
      gs => g,
      as => a,
      bs => b }.each do |sharp, nat|
      sharp.natural_rank.should == nat.rank
    end
  end
  
  it "can be cast to an Integer" do
    [cs,ds,es,fs,gs,as,bs].each do |a|
      a.to_i.should == a.rank
    end
  end
  
  it "has a String representation" do
    if ruby19?
      { cs => "C\u{266F}",
        ds => "D\u{266F}",
        es => "E\u{266F}",
        fs => "F\u{266F}",
        gs => "G\u{266F}",
        as => "A\u{266F}",
        bs => "B\u{266F}" }.each do |pc, s|
        pc.to_s.should == s
      end
    else
      { cs => "C#",
        ds => "D#",
        es => "E#",
        fs => "F#",
        gs => "G#",
        as => "A#",
        bs => "B#" }.each do |pc, s|
        pc.to_s.should == s
      end
    end
  end
end

describe Flat do
  it "is defined in terms of a natural PitchClass" do
    { cf => c,
      df => d,
      ef => e,
      ff => f,
      gf => g,
      af => a,
      bf => b }.each do |sharp, nat|
      sharp.should == nat.flat 
    end
  end
  
  it "has a rank" do
    { cf => c,
      df => d,
      ef => e,
      ff => f,
      gf => g,
      af => a,
      bf => b }.each do |a,pc|
      a.rank.should == pc.rank - 1 
    end
  end
  
  it "has a natural rank" do
    { cf => c,
      df => d,
      ef => e,
      ff => f,
      gf => g,
      af => a,
      bf => b }.each do |a,pc|
      a.natural_rank.should == pc.rank 
    end
  end
  
  it "can be cast to an Integer" do
    [cf,df,ef,ff,gf,af,bf].each do |a|
      a.to_i.should == a.rank 
    end
  end
  
  it "has a String representation" do
    if ruby19?
      { cf => "C\u{266D}",
        df => "D\u{266D}",
        ef => "E\u{266D}",
        ff => "F\u{266D}",
        gf => "G\u{266D}",
        af => "A\u{266D}",
        bf => "B\u{266D}" }.each do |pc, s|
        pc.to_s.should == s
      end
    else
      { cf => "Cf",
        df => "Df",
        ef => "Ef",
        ff => "Ff",
        gf => "Gf",
        af => "Af",
        bf => "Bf" }.each do |pc, s|
        pc.to_s.should == s
      end
    end
  end
end

describe "All PitchClass representations" do
  it "has a canonical ordering" do
    [c,d,e,f,g,a,b].each do |pc|
      (pc.flat < pc).should be_true
      (pc < pc.sharp).should be_true
    end
    
    { cs => df,
      ds => ef,
      es => f,
      fs => gf,
      gs => af,
      as => bf }.each do |x, y|
      x.should < y 
    end
  end
  
  it "results in a new pitch class when semitones are added" do
    (c + 1).to_i.should == c.to_i + 1
  end
  
  it "are equivalent to themselves when adding 12 semitones" do
    [cf,c,cs,df,d,ds,ef,e,es,ff,f,fs,gf,g,gs,af,a,as,bf,b,bs].each do |pc|
      (pc + 12).should == pc
      (pc + -12).should == pc
      (pc - 12).should == pc
      (pc - -12).should == pc
    end
  end
  
  it "may be used as Hash keys" do
    c.hash.should == c.hash
    cs.hash.should == cs.hash
    cf.hash.should == cf.hash
    
    # Enharmonics - no cheating with pitch integers!
    c.hash.should_not == bs.hash
    c.hash.should_not == d.flat.flat.hash
  end
end
