class Golf
  Z=-1
  class << self
    def hole1 n
      n.inject(1){|s,i| s * i}
    end

    def hole2 n
      n.split.sort_by{|w| w[1]}.join' '
    end

    def hole3 n
      n == 1 ? 1 : n * hole3(n-1)
    end

    def hole4 n
      n.map { |w| case w
        when /man/
          "hat(#{w})"
        when /dog/ 
          w.gsub /\)$/, '(bone))'
        when /cat/ 
          w.gsub /cat/, 'dead'
        end
      }
    end

    def hole5 n
      return [] if n == []
      h, *t = n
      o = [[h]]
      t.size.times do |x|
        o << [h, *t[0..x]]
      end
      (o + hole5(t)).sort {|a,b| x = a.size <=> b.size; x == 0 ? a[0] <=> b[0] : x}
    end

    def hole6 n
      (1..n).map { |x|
        r = x
        r = "fizz" if x % 3 == 0
        r.to_s == r ? r += "buzz" : r = "buzz" if x % 5 == 0
        r
      }
    end

    def hole7 n
      n[1..Z].inject([[n[0]]]) { |r, x|
        r[Z][Z]+1 == x ? r[Z] << x : r << [x]
        r
      }.map { |x| [x[0], x[Z]].uniq.join'-' }
    end

    def hole8 n
      x = [1] * n
      2.upto(n-1) { |i| x[i] = x[i-1] + x[i-2]}
      x
    end

    def hole9 n
      l = File.readlines n
      t = l.size / 2
      d = l.map{|r| r.split(',').map &:strip }
      w = proc { |d|
        v = d.map { |v| v[0] }.inject(Hash.new(0)) { |h,c| h[c] = h[c] + 1;h}
        r = v.to_a.sort_by {|x| x[Z]}.reverse
        r[0][Z] >= t ? r[0][0] : w[d.map { |v| v[0] == r[Z][0] ? v[1..Z] : v }]
      }
      w[d]
    end
  end
end
