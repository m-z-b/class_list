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

  # Arguments may be files or directories
  def process( *args )
    if args.count == 0
      $stderr.puts "ClassList V#{VERSION} - crudely find all the Ruby classes defined in a set of files or directories"
      $stderr.puts 
      $stderr.puts "    Usage: classlist file1.rb file2.rb dir1 dir2 ..."
      exit 1
    end
    args.each do |arg|
      if Dir.exist?(arg)
        process_dir(arg)
      elsif File.exist?(arg)
        process_file(arg)
      else
        $stderr.puts "Path #{arg} does not found"
        exit 1
      end
    end
    self
  end


  def print_all
    puts "Class                Children"
    puts "-------------------------------------------"
    print( 0, @children.keys.select{|c| !@child.member?(c)}.sort )
  end

private

  def is_parent?( klass )
    @children.has_key?( klass )
  end


  # Process all '.rb. files and any subcirectories
  def process_dir( dir )
    #puts "Scanning #{dir}"
    Dir.foreach( dir ) do |entry|
      if entry.start_with?('.')
        next
      end
      path = "#{dir}/#{entry}"
      if Dir.exist?(path)
        process_dir(path)
      elsif entry.end_with?( '.rb' )
        process_file( path )
      end
    end
  end

  # Process a single file
  def process_file( file )
    #puts "Scanning #{file}"
    File.open(file,'r') do |f|
      f.each_line do |line|
        m = CHILD_CLASS_DECLARATION.match( line ) 
        if m
          #puts "#{m[1]} -> #{m[2]}"
          @children[m[2]].add(m[1])
          @child.add(m[1])
          next
        end
        m = SIMPLE_CLASS_DECLARATION.match(line)
        if m
          #puts "#{m[1]}"
          @children[m[1]] = Set.new
          next
        end
      end
    end
  end


  def print( level, enum )
    enum.each do |k|
      printf( "%s%s\n", " " * level * 4, k)
      if is_parent?(k)
        print( level+1, @children[k].sort )
      end
    end
  end


end


