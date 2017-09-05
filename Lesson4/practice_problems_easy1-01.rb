puts <<-QA
Q. Which of the following are objects in Ruby? If they are objects, how can you find out what class they belong to?

true
"hello"
[1, 2, 3, "happy days"]
142

A. These are all objects.  You can apply the .class method to any object to find out its class.

QA

p true.class
p "hello".class
p [1, 2, 3, "happy days"].class
p 142.class