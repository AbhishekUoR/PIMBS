/home/ziyang/Pmem/redis-3.0.1/src/redis-benchmark -q -n 100000
#### just run test the SET and LPUSH commands
# /home/ziyang/Pmem/redis-3.0.1/src/redis-benchmark -t set, lpush  -q -n 100000
#### specify the command to benchmark directly
# redis-benchmark -n 100000 -q script load "redis.call('set','foo','bar')" script load redis.call('set','foo','bar'): 69881.20 requests per second
#### Redis supports /topics/pipelining, running the benchmark using a pipelining of 16 commands:         
# redis-benchmark -n 1000000 -t set,get -P 16 -q
