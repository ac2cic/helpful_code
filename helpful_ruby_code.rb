There is no need to reinvent the wheel.

  ~ helpful Ruby code ~

#__________string_manipulation__________

# allows the use of both '' and "" inside a string
str1 = %q[ruby ' strings "] #like single-quoting
str2 = %Q[quoting with #{str1}] #like double-quoting, will allow interpolation

# gsub does split and join at the same time
string.gsub.('.','-')
string.split('.').join('-') 
# "example.test" => "example-test"

# splits string at - and ~
str.split(/\-|\~/) # "one-two~three" => ["one", "two", "three"]

# sorts based on non-standard alphabet
def alphabetize(array)
  esp="abcĉdefgĝhĥijĵklmnoprsŝtuŭvz" #esperanto alphabet
  ascii = "@-\\" #"@-\\" = "@ABCDEFGHIJKLMNOPQRSTUVWXYZ[\\"
  array.sort_by{|string| string.tr(esp, ascii)}
end
# ["teŝt", "test"] => ["test", "teŝt"]

# given a string (containing one word) and an array of strings
# returns the strings that are anagrams of the word
def match(word, string_array)
  string_array.select {|string| string.split("").sort == word.split("").sort}
end

#__________meta_programming__________

# the splat operator '*' tells a method to accept an unspecified number of arguments as an ARRAY
def example(*array_of_arguments)

#this method expects a single hash as an argument
def example(name:, age: 18) #age is defaulted to 18 if not specified
  puts age # don't use symbols in the body of the method
  puts :name # this will print the symbol "name" instead of "Andrew"
end
# despite being passed in the "wrong order", name will still be "Andrew" and age will be 24
example(age: 24, name: "Andrew")

# accepts a hash, creates new instance variables named after the keys, and sets them equal to the corresponding value
def example(hash_of_arguments)
  hash_of_arguments.each {|key,value| self.send("#{key}=", value) }
end
# however, setter methods must already exist for these new attributes because .SEND is trying to call them

class Example
  def initialize
    @status = "instantiated"
  end
end
obj = Example.new
# access obj's @status without calling, or even defining, getter/setter methods
obj.instance_variable_get("@status") #can pass @status as a string...
# @status => "instantiated"
obj.instance_variable_set(:@status, 123)#...or a symbol.
# @status => 123

# by combining the previous two concepts, we can create an initialize method that will accept a hash...
# ...with any number of key/value pairs and instantiate a new object attribute for each.
class Example
  def initialize(attr_hash)
    attr_hash.each {|key, value| self.instance_variable_set("@#{key}", value) }
  end
end
obj = Example.new(status: "instantiated", name: "Andrew", age: 24, hello: "world")
# right now, the only way to get these values is to use "instance_variabe_get"
# however, we can write the attr macros for the attributes we expect and ignore the rest
# this is bad design but I thought it was cool

#__________Time__________

start = Time.now
#some code executes...
puts Time.now - start
# measures runtime

#format Time object as a string
Time.now.strftime("%d/%m/%Y %H:%M") # => "01/02/2003 4:56"

#__________terminal/bash_commands__________

in 'PRY', use 'ls' followed by an object or class to show ALL instance/class attributes and methods available
#ie: ls "String".class

git grep 'search_term'
  => shows all files and lines (in that directory) where the 'search_term' appears

in pry/irb you can execute terminal commands with system()
#ie: system('ls')
#ie: system(say "test")

#__________external_files__________

#use a hash if you're managing multiple database connections
DB = SQLite3::Database.new('db/users.db')
DB = { users: SQLite3::Database.new('db/users.db'),
       posts: SQLite3::Database.new('db/posts.db') }
DB[:posts].execute("sql here")

# puts each line of a file into an array as a string
array = File.readlines('filepath')

# makes API request, recieves data in JSON, and parses it into a ruby hash
require 'rest-client'
require 'json'
response_string = RestClient.get('api request here')
response_hash = JSON.parse(response_string)

#__________misc__________

# conditional assignment operator
||= sets value if the variable currently has nil
x = nil; x ||= 2; # x => 2
x =   1; x   = 2; # x => 1

# '?' allows for an if AND an else statement on one line
evaluation ? true_case : false_case
var  = 1
var == 0 ? 'var is equal to zero' : 'var is NOT equal to zero'
# as opposed to only an if statement
var = 1
'var is equal to zero'     if var == 0
'var is NOT equal to zero' if var != 0

#.flatten will put all elements of a nested array into a single array
[ [["flatten"], ["method"]], "test"].flatten => ["flatten", "method", "test"]
#.flatten can be given an argument that specifies exactly how many layers of the array to flatten
[ [["flatten"], ["method"]], "test"].flatten(1) => [["flatten"], ["method"], "test"]

longest_review: self.reviews.max_by {|r| r.content.length } 
avg_rating: self.reviews.map(&:rating).sum / self.reviews.count.to_f









