class Sudoku  
  @mreza = []
  #inicalizuj mrezu
  def initialize(mreza_string = "", nivo)
    if mreza_string != ""
      @mreza = mreza_string.split("").map { |str| str.to_i }

      raise Exception if !validno?
    else
      until validno?
        generisi
      end
      
      until (ocigledni.length <= 17) && (pogodci <= nivo)
        
        kopiraj = self.dup
        
        known = (0...81).to_a - nepoznati
        cell = known.sample

        kopiraj.povuci_mrezu[cell] = 0
        kopiraj.povuci_mrezu[drugacije_of(cell)] = 0

        
        if kopiraj.resivo?
          @mreza = kopiraj.povuci_mrezu
        end
      end
    end
  end
  #da li je moguce resiti 
  def resivo?
    
    if pogodci < 17
      return false
    end
    
    kopiraj = self.dup
    kopiraj.resi!
    
    return kopiraj.reseno?
  end

  #reseno 
  def reseno?
    return !@mreza.include?(0) && validno?
  end
  
  def resi!
    nepromenjeno = false
    imin = nil
    pmin = []
    min = 10
    
    until(nepromenjeno)
      
      nepromenjeno = true
      
      nepoznati.each do |i|
        moguci = moguci(red_of(i), kolona_of(i))
      
        if(moguci.length == 1)
          self[red_of(i), kolona_of(i)] = moguci[0]
          nepromenjeno = false
        else
          if nepromenjeno && (moguci.length < min)
            imin = i
            pmin = moguci
            min = pmin.length
          end
        end
      end
    end
    
    unless self.reseno?
      resenja = []
      pmin.each do |guess|
        novo_kopiraj = dup
        novo_kopiraj[red_of(imin), kolona_of(imin)] = guess
        novo_kopiraj.resi!
        if novo_kopiraj.reseno?
          resenja.push(novo_kopiraj.povuci_mrezu)
          if resenja.uniq.length > 1
            return false
          end
        end
      end
      
      if ((resenja.length != 0) && (resenja.uniq.length == 1))
        @mreza = resenja[0]
      end
    end
  end
  
  def dup
    kopiraj = super
    @mreza = @mreza.dup
    return kopiraj
  end
  
  def [](red, kolona)
    return @mreza[red*9 + kolona]
  end
  
  def []=(red, kolona, novoval)
    @mreza[red*9 + kolona] = novoval
  end
  
  def to_s
    return @mreza.join("")
  end
  
  #metod koji vraca mrezu
  def povuci_mrezu
    return @mreza
  end
  
  private
  
    #metoda za genereisanje svih brojeva
    def generisi
      @mreza = [0] * 81
    
      0.upto 8 do |red|
        0.upto 8 do |kolona|
          @mreza[red*9 + kolona] = moguci(red, kolona).sample
        end
      end
    end
  
    #moguci brojevi
    def moguci(red, kolona)
      return [1,2,3,4,5,6,7,8,9] - (brojeviReda(red) + brojeviKolona(kolona) + brojeviKutija(kutija_of(red, kolona)))
    end
    
    def nepoznati
      return @mreza.each_index.select { |i| @mreza[i] == 0 }
    end
    
    def ocigledni
      return nepoznati.select { |i| moguci(red_of(i), kolona_of(i)).length == 1 }
    end
    
    def validno?
      return false unless @mreza
      
      return false unless @mreza.length == 81
      
      @mreza.each do |val|
        return false unless val

        if (val < 0) || (val > 9)
          return false
        end
      end

      return !ima_duplikata
    end

    def ima_duplikata
      0.upto(8) do |i|
        if brojeviReda(i).uniq.length != brojeviReda(i).length
          return true
        elsif brojeviKolona(i).uniq.length != brojeviKolona(i).length
          return true
        elsif brojeviKutija(i).uniq.length != brojeviKutija(i).length
          return true
        end
      end

      return false
    end
    
    def drugacije_of(cell)
      red = 8 - red_of(cell)
      kolona = 8 - kolona_of(cell)
      
      return red * 9 + kolona
    end
    
    def pogodci
      return @mreza.count do |h|
        h != 0
      end
    end
    
    #oznaci kutiju 
    def kutija_of(red, kolona)
    
      pokazuje = [0,0,0,1,1,1,2,2,2]*3 + [3,3,3,4,4,4,5,5,5]*3 + [6,6,6,7,7,7,8,8,8]*3
    
      return pokazuje[red * 9 + kolona]
    end
  
    def red_of(index)
      pokazuje = [0]*9 + [1]*9 + [2]*9 + [3]*9 + [4]*9 + [5]*9 + [6]*9 + [7]*9 + [8]*9
    
      return pokazuje[index]
    end
  
    def kolona_of(index)
      pokazuje = [0,1,2,3,4,5,6,7,8]*9
    
      return pokazuje[index]
    end
  
    #mapiranje brojeva 
    def brojeviReda(red)
      @mreza[red*9, 9] - [0]
    end
  
    def brojeviKolona(kolona)
      result = []
      kolona.step(80, 9) do |i|
        v = @mreza[i]
        result << v if (v != 0)
      end
    
      return result
    end
    # prvi inex u svakoj kutiji 0, 3, 6, 27, 30, 33, 54, 57, 60
    def brojeviKutija(kutija)
      kutijaes_pokazuje = [0, 3, 6, 27, 30, 33, 54, 57, 60]
    
      i = kutijaes_pokazuje[kutija]
    
      [
        @mreza[i],     @mreza[i+1],   @mreza[i+2],
        @mreza[i+9],   @mreza[i+10],  @mreza[i+11],
        @mreza[i+18],  @mreza[i+19],  @mreza[i+20]
      ] - [0]
    end
  
end


