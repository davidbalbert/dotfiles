require 'pathname'

module A
  class CtlLine
    def initialize(s)
      @s = s
    end
    
    def dir?
      field(3).to_i == 1
    end
    
    def field(i)
      @s[(i * 12)...((i + 1) * 12)]
    end
  end
  
  class Win
    attr_reader :id
    
    def initialize(id)
      @id = id
    end
    
    def file
      f = tag.split(" ")[0]
      
      if dir? || special?(f)
        Pathname.new(f[0...f.rindex("/")])
      else
        Pathname.new(f)
      end
    end
    
    def dir?
      CtlLine.new(ctl).dir?
    end
    
    def file?
      !dir?
    end
    
    def tag
      tagfile.read
    end
    
    def ctl
      ctlfile.read
    end
    
    def tagfile
      windir + "tag"
    end
    
    def ctlfile
      windir + "ctl"
    end
    
    def windir
      acmedir + id
    end
    
    def acmedir
      Pathname.new("/mnt/acme")
    end
    
    
    private
    
    def special?(path)
      i = path.rindex("/")
      
      return false unless i
      
      path[i + 1] == "+" || path[i + 1] == "-"
    end
  end
end
