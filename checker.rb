require 'benchmark'

Benchmark.bm 2000 do |r|
  r.report do
    `ruby main.rb #{ARGV[0]}`
  end
end
