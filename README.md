* Install bundler

```gem install bundler```

* Run bundle install

```bundle install ```

I recommend you start working in pry (or irb). The sooner you do, the sooner this will make sense.

I also recommend that you take stuff out of your initialize methods, at least for the time being.

Do the minimum in your initializer to get the object set up and then open up a console (pry or irb) load your classes,
and experiment.

Note while in pry it will print the results of the last command. It sends these results through a pager which prints 1 screen at a time. If there is more than fits on one screen the last line will be a :  you can hit space to see next page or q to quit. If you keep hitting space you will eventually get to the end and you'll see "(END)" at this point enter q to get back to your pry prompt.

to exit pry type exit at a pry prompt.

in pry:
```
load('./module2_assignment.rb')
sol = Solution.new
analyzers = sol.analyze_file('file_to_analyze')

#using a range here to limit analysys to the first 11 lines
sol.calculate_stats(analyzers[0..10])

# this will show the instance variables of sol
sol

```

if you need to change the file, then reload and repeat
if you want to see what's going on in a method, insert a binding.pry line. You will have access to everything that's in 
scope at that time


Once you have everything working the way you want, you can either add back methods to the initialize method, or better 
is just to add code after the class defs:

```
sol = Solution.new('path_to_file')
analyzers = sol.analyze_file # no need to give it a path if you initialized sol with the correct file
...
```
