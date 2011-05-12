# This solution does the sort, but we don't need to because the examples are already in numerical order
def Gold.hole5 n
  (1..n.size).map { |x|
    [*n.each_cons(x)]
  }.flatten(1).sort {|a,b|
    x = a.size <=> b.size
    x == 0 ? a[0] <=> b[0] : x
  }
end

# This solution seems more correct, but it's longer... :(
def Gold.hole9 n
  l = IO.readlines n
  t = l.size / 2.0
  w = proc { |a|
    e = a.inject(Hash.new 0) { |h,c|
      h[c[0]] = h[c[0]] + 1
      h
    }
    r = e.sort_by {|x| x[Z]}
    (r[Z][Z] >= t || r.size == 2) ? r[Z][0] : w[a.map { |v| 
      v.delete r[0][0]
      v
    }.select &:any?]
  }
  w[l.map{|s| s.split(",").map &:strip }]
end
