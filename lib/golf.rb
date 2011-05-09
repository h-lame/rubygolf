class Golf
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
        when /man/ : "hat(#{w})"
        when /dog/ : w.gsub(/\)$/, '(bone))')
        when /cat/ : w.gsub(/cat/, 'dead')
        end
      }
    end

    def hole5 n
      return [] if n == []
      h, *t = n
      o = [[h]]
      t.size.times do |x|
        o << [h, t[0..x]].flatten
      end
      (o + hole5(t)).sort {|a,b| x = a.size <=> b.size; x == 0 ? a[0] <=> b[0] : x}
    end

    def hole6 n
      (1..n).to_a.map { |x|
        r = x
        r = "fizz" if x % 3 == 0
        r.is_a?(String) ? (r += "buzz") : (r = "buzz") if x % 5 == 0
        r
      }
    end

    def hole7 n
      n[1..-1].inject([[n[0]]]) { |r, x|
        r[-1][-1]+1 == x ? r[-1] << x : r << [x]
        r
      }.map { |x| [x[0], x[-1]].uniq.join'-' }
    end

    def hole8 n
      x = [1] * n
      2.upto(n-1) { |i| x[i] = x[i-1] + x[i-2]}
      x
    end

    def hole9 n
      lines = File.readlines n
      threshold = lines.count / 2
      d = lines.map{|r| r.strip.split(',')}
      votes = d.map { |v| v[0] }.inject(Hash.new(0)) { |h,c| h[c] = h[c] + 1;h}
      result = votes.to_a.sort_by {|x| x[-1]}.reverse
      if result.first[-1] >= threshold
        result.first[0]
      else
        loser = result.last[0]
        votes.each { |v| v.shift if v[0] == loser}
        votes = d.map { |v| v[0] }.inject(Hash.new(0)) { |h,c| h[c] = h[c] + 1;h}
        result = votes.to_a.sort_by {|x| x[-1]}.reverse
        if result.first[-1] >= threshold
          result.first[0]
        else
          loser = result.last[0]
          votes.each { |v| v.shift if v[0] == loser}
          votes = d.map { |v| v[0] }.inject(Hash.new(0)) { |h,c| h[c] = h[c] + 1;h}
          result = votes.to_a.sort_by {|x| x[-1]}.reverse
          result.first[0]
        end
      end
    end
  end
end
