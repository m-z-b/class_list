require "class_list/version"
require 'set'


class ClassList

  # Match a class A < B type declaration
  CHILD_CLASS_DECLARATION = /^\s*class\s+([A-Z][A-Za-z0-9]*)\s+<\s+([A-Z][A-Za-z0-9]*(::[A-Z][A-Za-z0-9]*)*)/
  # Match a class A delcaration
  SIMPLE_CLASS_DECLARATION = /^\s*class\s+([A-Z][A-Za-z0-9]*)/

  def initialize
    @child = Set.new
    @children = Hash.new{ |h,k| h[k] = Set.new }
  end

  def process( *files )
    files.each do |file|
      #puts "Scanning #{file}"
      File.open(file,'r') do |f|
        f.each_line do |line|
          m = CHILD_CLASS_DECLARATION.match( line ) 
          unless m.nil?
            #puts "#{m[1]} -> #{m[2]}"
            @children[m[2]].add(m[1])
            @child.add(m[1])
            next
          end
          m = /class\s+([A-Z][A-Za-z0-9]*)/.match(line)
          unless m.nil?
            #puts "#{m[1]}"
            @children[m[1]] = Set.new
            next
          end
        end
      end
    end
    self
  end

  def is_parent?( klass )
    @children.has_key?( klass )
  end

  def print( level, enum )
    enum.each do |k|
      printf( "%s%s\n", " " * level * 4, k)
      if is_parent?(k)
        print( level+1, @children[k].sort )
      end
    end
  end

  def print_all
    puts "Class                Children"
    puts "-------------------------------------------"
    print( 0, @children.keys.select{|c| !@child.member?(c)}.sort )
  end

end



end
