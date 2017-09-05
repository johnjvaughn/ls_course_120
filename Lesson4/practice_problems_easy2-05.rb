puts <<-QA

excited_dog = "excited dog"
@excited_dog = "excited dog"
@@excited_dog = "excited dog"

Q. What are the different variable types and how do you know which is which?

A. excited_dog is a local variable because it has no prefix such as @.
   @excited_dog is an instance variable, indicated by the single @ prefix.
   @@excited_dog is a class variable, indicated by the double @ prefix.

QA
