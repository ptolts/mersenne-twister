I wanted to learn more about PRNG code after reading [this article on the v8 PRNG](http://hackaday.com/2015/12/28/v8-javascript-fixes-horrible-random-number-generator/). I implemented a mersenne twister based on Wikipedia pseudocode. Definitely makes me appreciate how difficult crypto is.

![alt text](/random.png 'Image generated using my mersenne code. Looks random eh?')
Mersenne Random Image

![alt text](/bad_random.png 'Image generated using the bad algorithm from V8. As you can see there are issues.')
Bad V8 Algorithm Image

#Links

http://boallen.com/random-numbers.html

https://www.random.org/analysis/

https://en.wikipedia.org/wiki/Mersenne_Twister
