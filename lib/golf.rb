Golf = Hash
Z=-1
B=[0,
  '
    n.inject :*
  ','
    n.split.sort_by{|w| w[1]} * " "
  ','
    hole1(1..n)
  ',%q{
    n.map { |w|
      w =~ /man/ ? "hat(#{w})" : w.gsub(/(dog.*)\)$/, '\1(bone))').gsub(/cat/, 'dead')
    }
  },'
    n == [] ? [] : (
      h, *t = n
      o = [[h]]
      t.size.times { |x|
        o << [h, *t[0..x]]
      }
      (o + hole5(t)).sort {|a,b|
        x = a.size <=> b.size
        x == 0 ? a[0] <=> b[0] : x
      }
    )
  ','
    b = "buzz"
    (1..n).map { |x|
      r = x % 3 == 0 ? "fizz" : x
      x % 5 == 0 ? r.to_s == r ? r + b : b : r
    }
  ','
    n[1..Z].inject([[n[0]]]) { |r, x|
      r[Z][Z]+1 == x ? r[Z] << x : r << [x]
      r
    }.map { |x| [x[0], x[Z]].uniq * "-" }
  ','
    x = [1] * n
    2.upto(n-1) { |i| x[i] = x[i-1] + x[i-2]}
    x
  ','
    l = IO.readlines n
    t = l.size / 2
    w = proc { |d|
      v = d.inject(new 0) { |h,c|
        h[c[0]] = h[c[0]] + 1
        h
      }
      r = v.sort_by(&:last)
      r[Z][Z] >= t ? r[Z][0] : w[d.map { |v| v[0] == r[0][0] ? v[1..Z] : v }]
    }
    w[l.map{|r| r.split(",").map &:strip }]
  ']
(1..9).map {|i|
  eval "
def Golf.hole#{i} n
  #{B[i]}
end"
}
    

