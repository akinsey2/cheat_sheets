

# Python DOES NOT support PRIVATE methods or attributes in classes!

##### Syntax

## Naming restrictions

# 1. Variables must START with letter or "_"
# 2. Variable names can only contain letters, numbers, and underscores (NO PERIODS)

## Naming conventions

# 1. snake_case for variables: all lower case with underscores
# 2. CAPS_SNAKE_CASE for constants: all upper case with underscores
# 3. UpperCamelCase for classes: no underscores
# 4. __private_do_not_edit__ for private/restricted vars: all lower case with "dunder", double underscore wrapped
# 5. _private_method() within a class should have starting underscore

##### Data Types

type(x)			# Determine data type

bool()	# False == [False, None, 0, '', (), [], set(), range(0)]
		# True == everything else non-zero or non-empty
		# MUST start capitalized.  Sub-type of "int"


## Numeric Types
int() 	# Convert using int(x)
float()	# Usually implemented as "double" in C
		# convert with float(x)
complex()	# two floats.... z can be accessed as z.real and z.imag
		# complex(re, im) creating function

## "Normal" Sequence Types
str()		# IMMutable, ordered sequence of Unicode code points
list()		# Mutable, ordered sequence of values, array, vector, [1,2,3] or ["a","b","c"]
tuple()		# IMMutable, ordered sequence of values...i.e. array, vector
range()		# unique numeric construct for iterating loops

# Binary Sequence Types
bytes()			# IMMutable sequence of single bytes.  ASCII-compatible, closely related to string objects
bytearray()		# Mutable version of "bytes()".  Mutable sequence of single bytes
memoryview()	# object enables Python code to access the internal data of 'bytes()' and 'bytearray()' via the buffer protocol without copying.	

# Mapping Types
dict()		# a collection of {key, value} pairs.  e.g. {"first_name": "Colt", "last_name": "Steele"}

# Set Types
set()		# Unordered, mutable collection of unique items/values
frozenset()	# Unordered, IMMutable collection of unique items/values

# Other Types:
module()
class()			
function()		# Created by function definitions.  Only operation is to call a function
method()		# functions that are called using the attribute notation
None()			# There is exactly one null object, named None (a built-in name)


#---------------------------------------------
###### Operator Precedence  (highest to lowest)
#---------------------------------------------

(expressions...),							# Binding or parenthesized expression, list display, dictionary display, set display
[expressions...], {key: value...}, {expressions...}
------------------------------
x[index], x[index:index], x(arguments...), x.attribute		# Subscription, slicing, call, attribute reference
------------------------------
await x 									# Await expression
------------------------------
** 											# Exponentiation
------------------------------
+x, -x, ~x 									# Positive, negative, bitwise NOT
------------------------------
*, @, /, //, % 								# Multiplication, matrix multiplication, division, floor division, remainders
------------------------------
+, - 										# Addition and subtraction
------------------------------
<<, >> 										# Shifts
------------------------------
& 											# Bitwise AND
------------------------------
^ 											# Bitwise XOR
------------------------------
| 											# Bitwise OR
------------------------------
in, not in, is, is not, <, <=, >, >=, !=, == #Comparisons, including membership tests and identity tests
------------------------------
not x 										# Boolean NOT
------------------------------
and											# Boolean AND
------------------------------
or 											# Boolean OR
------------------------------
if – else 									# Conditional expression
------------------------------
lambda:										# Lambda expression
------------------------------
:=											# Assignment expression
------------------------------


## General

+= 				# take the variable and add/concat something to it.
-=				# take the variable and subract/anticat something to it.
**, pow(x,y) 	# Exponent Operator
%  				# Modulo Operator: 11 % 5 -> 1
// 				# Integer/Floor Division Operator: 9 // 2 -> 4, 9.0 // 2.0 -> 4.0
				# But if one of the operands is negative, the result is floored, i.e., rounded away from zero
				# -11.0 // 3 -> -4.0
divmod(x,y) == (x // y, x % y)
abs(x)			# Absolute value of x
c.conjugate(z)	# Complex conjugate of z

## Bitwise

|		# bitwise OR
^		# bitwise XOR
&		# bitwise AND
x << n 	# x left-shifted 'n' bits
x >> n 	# x right-shifted 'n' bits
~x 		# invert all bits of x

## Boolean Operators

and 	# general AND
or 		# general OR
not		# general negation


## Comparison Operators

<		# strictly less than
<=		# less than or equal
>		# strictly greater than
>=		# greater than or equal
==		# are the CONTENTS of two objects equal? (whether same location in memory or not)
!=		# not equal
is  	# are two objects referencing the same location (object) in memory? object identity
is not 	# negated object identity


## Sequence Operators  (for list, tuple, range)

x in s  			# 'True' if an item of s is equal to x, else 'False'
x not in s 			# 'False' if an item of s is equal to x, else 'True'
s + t 				# Concatenation of s an t
(s * n) or (n * s) 	# equivalent to adding s to itself n times
s[i] 				# ith item of s, origin 0
s[i:j]				# slice of s from i to j
s[i:j:k]			# slice of s from i to j with step k
len(s)				# length of s
min(s)				# smallest item of s
max(s)				# largest item of s
s.index(x[, i[, j]])# index of the first occurrence of x in s (at or after index i and before index j)
s.count(x)			# total number of occurrences of x in s


##############################
##### Loops, Iterators, Generators
##############################

range(start, stop, step)	# up to, but NOT including STOP

for Iter in interable: 
	do_something()
	break

while condition_is_true:
	do_this_but()
	if this_other_thing:
		continue
	dont_do_this()

# CRUCIAL ITERATION FUNCTIONS
# An ITERABLE is any object which can be used to create an iterator....string, list, tuple, dict, etc.
###
iterator = iter(iterable)
next(iterator)		# Takes one step through the iterable and returns one element.
###

def for_loop_print(iterable):
	iterator = iter(iterable)
	while True:
		try:
			item = next(iterator)
		except StopIteration:
			break
		else:
			print(item)

# A GENERATOR OBJECT is an iterable obejct that contains no "data".
# Instead, it uses a function to "generate" a new value/item to be returned at each call to "next(generator_object_instance)"
# Generator objects are ONE TIME USE.  You must create a new instance of them each time you want to use one.
# Iterating with generators use FAR LESS MEMORY than iterating with data objects, but may be SLOWER

# A GENERATOR FUNCTION is way to create a generator OBJECT.  The function generates an instance of a generator object.
# a function that uses "yield" instead of return.

def count_up_to(maxi):		# A Generator function contains "yield" instead of "return", and creates generator object.
	count = 1
	while count <= maxi:
		yield count 
		count += 1

# GENERATOR OBJECTS
counter = count_up_to(10)	# A Generator object instance is returned by a generator function

# GENERATOR EXPRESSIONS - similar to dict or list comprehension, but with parens ()

gen_object = (5*i for i in range(100))


##############################
##### Strings 			(IMMUTABLE)
##############################

# Can use single or double quotes to declare strings
# "Escape Sequence" special characters with '\'

"\\" -> \
"\'\' \"\"" -> ''""
"\n" -> return / line_feed
"\t" -> tab

str1 + str2 -> [str1 str2], "your" + " face" -> "your face"
n = 66
f"are there {n} bible books?"
"are there {} bible books".format(66)

# Reverse strings handily
str1 = 'tacotruck'
str1[::-1] == 'kcurtocat'


##############################
##### Lists			(Dynamic Vectors/Arrays/Matrices, Ordered, mutable groups of info)
#####				REFERENTIAL Array: in memory, each position contains a reference/pointer to another object containing the item's contents
#####				Indexing: O(1) complexity
#####				Assignment to position: O(1) complexity
##############################

# Enclosed by square brackets []

list1 = [item1, "item2", 3.3333, int(4), True]
list1[0] == item1, list1[3] == 4
("item2" in list1) -> True

len(list1) == int(length_of_list) == 5

# SHALLOW copy (new list contains references to same objects as previous list)
list1_copy = list1[:]
list1_copy = list1.copy()

# DEEP copy (new list references NEW objects)
import copy 
list_deep_copy = copy.deepcopy(list1)


list1.append("something")					# Adds 1 item to the end of a list
list1.extend([3, "more", things])			# MUST be passed as list...A(dds multiple items to the end of a list
list1.insert(index_num, "insertion")		# Insert an item at a specific location in a list
list1.clear()								# Removes all items from list
last_element = list1.pop()					# Removes and returns the LAST item from a list
element = list1.pop(index_num)				# Removes and returns the item at specified index
list1.remove(this_value)					# Finds first instance of this_value and removes it from list.  Does NOT return item.
index_num = list1.index(item_to_match, start_index, end_index)	# Finds first instance of item_to_match in list1[start_index:end_index], and returns index int
num_occurences = list1.count(item_to_match)	# Counts number of instances of item_to_match in list1
list1.reverse()								# reverses the elements of a list (indeces) in place.
list1.sort(key=None, reverse=False)			# Sort in ascending order in place

# List Slicing		(END index NOT INCLUDED)

new_list_copy = list1[start:end:step]			# END is NOT included, is EXclusive...will only slice to end-1
												# START IS included, inclusive, will include start in slice
complete_list_copy    = list1[:]
end_of_list_copy      = list1[2:]				# get list from index 2 to the end
start_of_list_copy    = list1[:-2]				# Slice from start of list to index
some_list_copy        = list1[1::2]				# Can LEAVE OUT an argument... So this will return values with indices from 1 to end, stepping by 2
every_other_item_copy = list1[::2]				# Start of list to end of list, stepping by 2

list1 = [0,1,2,3,4,5,6,7,8,9]
list1[::-2]	== [9,7,5,3,1]			# Negative step value REVERSES slice....starts at end, ends at start, stepping backwards by 2
list1[:4:-2] == [9,7,5]				# Starts at end, ends at index 4+1, stepping backwards by 2...10 -> 8 -> 4

list1 = ["zero", "one", "two", "three", "four", "five", "six", "seven", "eight", "nine"]
list1[1:3][::-1]    == ["three", "two", "one"]
list1[-3][::-1]     == "neves" 
'0123456789'[8::-2] == "86420"

list1[4], list1[5] = list1[8], list1[9]		# SWAP / SHUFFLE: You can assign multiple values using comma syntax.  Allows you to sort/shuffle list in place.


'- -'.join(list1)				# String method...joins elements of list into a single string, converting them if necessary


##### List Comprehension  -  Concise syntax for loop operation on lists/iterables

# Somewhat obvious: a listcomp traverses the entire list and creates a new complete list, and can use significant memory.
# If memory is a concern, a Generator is a useful tool.

new_list = [ <operation> for <item> in <list1> ]		# MUST have enclosing brackets!!!
new_list = [ <operation_with_conditions> for <item> in <list1>]
new_list = [ <operation> for <item> in <list1> if <condition> ]

list1 = ['zephyr', 'salem', 'shiloh', 'spencer', 'bennett', 'ember', 'flynn', 'phoenix']
list2 = [ name.capitalize() for name in list1 ]

nums = [0,1,2,3,4,5,6,7,8,9,10]
evens = [i for i in nums if i % 2 == 0]
odds  = [i for i in nums if i % 2 != 0]
other_nums1 = [ 2*i if i% 2 == 0 else i/2 for i in nums]	# if even, double, if odd, halve (for all in nums)

with_vowels = "Let's remove some vowels"
"".join(char1 for char1 in with_vowels if char1 not in "aeiou") -> "Lt's rmv sm vwls"

##### Nested / Multidimensional Lists

sentence = ["lists", "of", "strings", "are", "nested", "lists"]
sentence[4][0:4] == "nest"

nums = [['00','01','02'],['10','11','12'],['20','21','22']]
nums[2][0]    == '20'
nums[2][::-1] == ['22','21','20'] 

nested_list_comprehension = [ [list_comprehension1] for <item> in <list1>]
nested_list_comprehension = [ [<operation> for <item> in <list2>] for <item> in <list1> ]
nested_list_comprehension = [ [list_comprehension1] for <item> in <list1> if <conditions>]
nested_list_comprehension = [ [list_comprehension1 if conditions] for <item> in <list1>]


##############################
##### Dictionaries			(Unordered Structure of Key-value pairs)=
##############################

# Enclosed by curly brackets {} with colon : notation ... NO ORDER IS GUARANTEED

# Create dicts
dict1 = {'key1': 'value1', 'key2': value2, "key3": True, 4: 'or-number-key'}
n_carolina = {"Motto": "Esse quam videri", "Population": 10500000, "Capital": "Raleigh", "is_conservative": True}		# more common
n_carolina = dict(Motto = "Esse quam videri", Population = 10500000, Capital = "Raleigh", is_conservative = True}		# Less common
{}.fromkeys(["key1", "key2", "key3"], None)		# Initializes a new dict with specified keys, but all the same values
dict.fromkeys(range(0,10), None)				# Same as above

# dict modify functions
n_carolina[Motto] -> ERROR					# Extract individual value
n_carolina["Motto"] -> "Esse quam videri" 	
dict1.get("key1") -> "value1"				# Extract individual value
dict1.get("not_a_key") -> None 				# Check if key exists
dict1.pop("key3") -> True					# REMOVES key-value pair from dict, returns value.  Must include key
dict1.popitem()								# REMOVE and return random key-value tuple from dict.

dict1.update(other_dict)					# Add all tuples of other_dict to dict1.  Will overwrite dict1.values() with other_dict.values() if any dict1.keys()==other_dict.keys()

# "in" with dicts.  By default, only checks KEYS
"Population" in n_carolina -> True 
"Raleigh" in n_carolina -> False
"Raleigh" in n_carolina.values() -> True

# Iterables / Loopables
dict1.keys()   -> dict_keys(['key1', 'key2', 'key3', 4])				# Returns list of keys		
dict1.values() -> dict_values(['value1', value2, True, 'or-number-key']	# Returns list of values	
dict1.items()  -> dict_items([('key1', 'value1'), ('key2', value2),		# Returns list of tuples
								("key3", True), (4, 'or-number-key')])
dict1.clear()				# Deletes all contents
dict1.copy()				# Makes a clone, separate location in memory

# Dict Loops
for key_i, value_i in n_carolina.items():
	print(key_i, value_i)
for value_i in n.carolina.values():
	print(value_i)
for key_i in n.carolina.keys():
	print(key_i)

# Dict Comprehensions  -- Inline syntax of tuple-wise looped operations to generate new dict

{ <key1-operation> : <value1-operation> for key1,value1 in dict1.items() }
YELLING = { key1.upper():value1.upper() for key1,value1 in dict1.items() }

#     with all conditionals

{ (<key1op1> if <cond1> else key1op2) : (<val1op1> if <cond2> else val1op2) for key1,val1 in dict1.items() }
{ <key1-oper> : <val1-oper> for key1,val1 in dict1.items() if <condition1>}

{ <key:}


##############################
##### Tuples			(IMMUTABLE ordered collection, like an immutable list)
##############################

# Enclosed in parens (), faster to execute
# Immutable after creation: cannot update, append, or edit

tuple1 = ('alpha', 'beta', 'gamma', 'delta', 'epsilon')			# create a tuple
tuple1 = tuple(['alpha', 'beta', 'gamma', 'delta', 'epsilon'])
tuple_one = tuple([1])
tuple1[0] -> 'alpha'
tuple1[-1] -> 'epsilon'

tuple2 = ('a','a','a','b','b')
tuple2.count('b') -> 2 				# count the number of occurences of item in tuple
tuple2.index('b') -> 3 				# return index of first occurence of item in tuple

dict1 = { (123, 456), "intitial numbers" }		# Tuples can be used as keys in dicts. 
nest_tuple = ( 1,2,(3,4), (5,6))				# Tuples can be nested 

(<item1>,)		# This is how Python prints single-item tuples, extra trailing comma to denote tuple
(5,)			#  to help distinguish them from just some value in parens


##############################
##### Sets			(Unordered group of elements WITHOUT duplicates)
##############################

# Create with curly brackets {} withOUT colon : notation
# Useful for removing duplicates in a list/array/string

set1 = {13,11,1,3,5,7}
set2 = set([13,13,1,3,5,5,7])		# duplicates are automatically removed.
set2 == set1

set1[4] -> ERROR				# Not ordered, cannot be indexed
11 in set1 -> True 				# CAN check existence of item in set
set1.add([17,19])				# Add an element to the set
set1.remove(13)					# Remove an element from the set
set1.discard(10)				# "soft" Remove, will attempt, but NO error if item does not exist
set1.copy()
set1.clear()					# Hard delete all contents of set

for <item> in set1:
	print(<item>)

# Set Math methods
set1 = {1,3,6,9,12,15,18,21,24,27,30}
set2 = {1,4,8,12,16,20,24,28,32}

set1 | set2 -> {1,3,4,6,8,9,12,15,16,18,20,21,24,27,28,30,32} 	# Set Union
set1 & set2 -> {24, 1, 12}										# Set Intersection

# Set Comprehension
{ <item-operation> for item in set1 }
{ itemop1 if cond1 else itemop2 for item in set1 }
{ itemop1 for item in set1 if cond1 else itemop2  }
onethird_set1 = { item/3 for item in set1 }
{ ch.upper() for ch in 'hello' } == {'O','L','H','E'}


##############################
##### Functions		
##############################

# Use snake_case for function names
# Good idea to set default values for parameters
# You CANNOT edit external variables inside a function without using "nonlocal" or "global"

# REMEMBER to INDENT "return" correctly for proper functionality!

# Parameters MUST be defined in the following order:
def func_def(params_no_defs, *args, params=with_defaults, **kwargs):

# REMEMBER to add a Docstring to briefly describe the function!!  (accessible via func_name.__doc__)

def pr_hello_world(param1 = 0, param2 = '0', fn1=func_name, *args):
	"""A Docstring: Describe what the function does here for documentation"""

	#write code here
	print("Hello World"
	print(args)
	(return_var1, return_var2) = fn1(param1, param2)
	return (return_var1, return_var2)			# "return" exits function

func_name.__doc__  # will access the contents of Docstring 

# PARAMETER is a variable name in a method definition...the arbitrary names you select
# ARGUMENT is the actual data that is passed into the parameter of a function.

# KEYWORD ARGUMENT is when you explicitly assign arguments to param names when calling a function
pr_hello_world(1,2,add)						# passing arguments implicitly
pr_hello_world(fn1=add, param2=2, param1=1)	# Keyword Argument example

# *args -- Allows you to pass in an arbitrary number of arguments
#			The asterisk MUST be present in the function definition
#			You can use any name instead of args, but * must exist
#			args is passed in as a TUPLE containing all arguments

def func_args(param1 = 1, *args):
	if param1:
		for arg in args:		# args is a TUPLE of arguments
			print(arg)
	else:
		print("I don't know") 
	return

# **kwargs -- Allows you to pass in an arbitrary number of keywords with arguments
#				Double asterisk MUST be present in function definition
#				You can use any name instead of kwargs, but ** must exist
#				kwargs is passed in as DICT containing { kw1:arg1, kw2:arg2 ... etc }

def func_kwargs(param1 = 1, **kwargs):
	for keyword, arg in kwargs.items():
		print(f"The keyword is {keyword} and argument is {arg}")
	return

# UNPACKING List/Tuple Args -- Pass elements of list/tuple as separate argument to function
#								Use the *list_name or *tuple_name when calling the function

def concat_strs(*args):
	return ' '.join(args)

concat_strs("Hello", "There") == 'Hello There'
#OR
list1 = ["This", "is", "cool!"]
concat_strs(*list1) == "This is cool!"		# Use the *list_name to unpack into individual arguments
tuple1 = ('and','with','tuples')		
concat_strs(*tuple1) == "and with tuples"	# Or *tuple_name

# UNPACKING Dict Args -- Pass key-value pairs of dicts as separate keyword arguments
#							

def mad_lib(noun1,noun2,verb1,adj1):
	return f"My {noun1} loves to {verb1} {adj1} {noun2}"

dict1 = {"adj1":"strong","noun1": "Grandmother", "verb1":"shoot", "noun2":"whiskey"}

mad_lib(**dict1)		# Unpack dict into named params with **


### Lambda / Anonymous Functions		

# By default, they have no name (unless assigned to a variable)
# Automatically returns the result of the operation

lambda param1,param2: <operation on params>  


# CLOSURE - Occurs when a function returns a function instead of a value.
#		  - When the nested "function" is returned, it is assumed that at some point that returned function will be evaluated.
#		  - In order for the returned function to be evaluated, it usually needs some variable values from the scope of the original function that returned it.
#		  - Thus a "closure" is the programming language "including" any needed local variables along with a function being returned.

def f(x):
	def g(y):
		return x+y 
	return g 

a = f(1)	# "a" is a closure.  It includes the function g, as well as the value of x = 1.
a(1) == 2 	# "a" can then be evaluated, and the closure ensures that the value of x is present for evaluation to be successful

# equivalent
def h(x):
	return lambda y: x+y 

b = h(1)	# "b" is also a closure
b(5) == 6 	# and can be evaluated

# DECORATORS - functions that "wrap around" other functions to add functionality
#			 - there is a special syntax available in Python for this, but not necessary to use.

def declare_wrap(func):
	# @wraps(func)											# The purpose of this line is described below
	def wrapper(*args, **kwargs):							# The standard pattern is to allow flexible arguments in the wrapper function
		"""A wrapper for implementing a \"decorator\""""	# So that any types of inputs of the wrapped function are supported and passed successfully	
		print("a function is about to execute")				
		func()
		print("a function is done executing")
	return wrapper

def my_func(arg1, arg2):
	"""A docstring function description"""
	print("I am a function.")

declare_wrap(my_func(arg1, arg2))	#  what the "decorator" syntax does in actuality

# The alternative syntax for this is below.  It requires the "@" symbol
# If my_func() is defined in this way, then every time my_func() is called, declare_wrap() is actually called first, 
# and my_func() is passed into and executed inside of declare_wrap()

@declare_wrap
def my_func(arg1, arg2):
	"""A docstring function description"""
	print("I am a function.")

# BUT...using decorators OBSCURES the metadata of the decorated function.
# With the decorator above:
# my_func.__name__ == "wrapper"
# my_func.__doc__ = "A wrapper for implementing a \"decorator\"
# help(my_func) will NOT work correctly

# To fix this, you must use "wraps" from "functools"
import wraps from functools

def declare_wrap(func):
	@wraps(func)
	def wrapper(*args, **kwargs):							# The standard pattern is to allow flexible arguments in the wrapper function
		"""A wrapper for implementing a \"decorator\""""	# So that any types of inputs of the wrapped function are supported and passed successfully	
		print("a function is about to execute")				
		func()
		print("a function is done executing")
	return wrapper


# DECORATORS - CUSTOMIZED WITH ARGUMENTS
#			 - If you want your decorator to have "configurable" functionality with an input argument,
#			 - you must "double wrap" the target function....nest it one level deeper.
#			 - the "first level" of the decorator will take in the customization argument and create the proper decorator function, and
#			 - the "second level" will actually execute the wrapped function with any additional logic

# The equivalent of what is happening is:

func = decorator_with_arg(arg)(func)

from functools import wraps

def ensure_first_arg_is(val):

	def top_level(func):

		@wraps(func)
		def wrapper(*args, **kwargs):
			if args and args[0] != val:
				return f"First arg needs to be {val}"
			return func(*args, **kwargs)
		return wrapper
	return top_level

@ensure_first_arg_is("rv10")
def best_planes(*planes):
	return planes

print(best_planes())
print(best_planes("rv10"))
print(best_planes("rv6"))
print(best_planes("rv10", "sling"))

@ensure_first_arg_is(10)
def add_nums(*args):
	return sum(args)

print(add_nums(10,1,2,3))
print(add_nums(1,2,3,4))

# Another example ----------------------------

def enforce(*types):
    def decorator(func):
        def new_func(*args, **kwargs):
            #convert args into something mutable   
            newargs = []        
            for (arg_i, type_i) in zip(args, types):
               newargs.append( type_i(arg_i)) 	# attempt to type-cast each argument
            return func(*newargs, **kwargs)
        return new_func
    return decorator

@enforce(str, int)		# Provide the types, in order, that you want to enforce
def repeat_msg(msg, times):
	for time in range(times):
		print(msg)

@enforce(float, float)
def divide(a,b):
	print(a/b)
# repeat_msg("hello", '5')
divide('1', '4')



##############################
##### Python Built-in Functions
##############################

id( object )		# a representation of the address of the object in memory.

map(func_name or lambda, iterable)  	# apply a function to every item in an iterable

def func_name(param1): return param1
list1 = [item1,item2,item3]

map_object = map(func_name, list1)		# takes every item in list1 (any iterable), and inputs it to function
map_object = map( lambda x: x, list1)	# returns a "map object" containing the items of list1 transformed by func_name

# !! MAP and FILTER objects can only be iterated through once, so convert them immediately!

# filter(func_name or lambda, iterable)  --  filter out values in an iterable

def is_even(num): return (num%2 == 0)
list1 = [1,2,3,4,5,6]

evens = list( filter(is_even, list1) )					# function passed to filter MUST return TRUE or FALSE
evens = list( filter( lambda x: x%2 == 0, list1 ) )		# filter() returns map object containing only values
														# for which func_name returned TRUE

# all( iterable )  --  returns TRUE only if ALL elements in iterable are truthy, else FALSE

all([1,'a',True, (1,)]) == True
all([0,'a',True, (1,)]) == False 

# any( iterable )  --  returns TRUE if ANY element of the iterable are truthy. If all are falsy, returns FALSE

any([0,False,'',[]]) == FALSE
any([1,False,'',[]]) == TRUE 

# sorted( iterable, key=func_name, reverse=False)  --  returns a new sorted LIST copy from the items in iterable, without changing iterable

nums1 = (1,3,2,5,4)
sorted(nums1) == [1,2,3,4,5]					# Always returns a list.  Does not edit original.
sorted(nums1, key=lambda x: x%2) == [2,4,1,3,5]	# Sorts ASCENDING by default
sorted(nums1, key=lambda x: x%2, reverse=True) == [1,3,5,2.4]
# Can also sort much more complex objects based on any of their properties/attributes!

# max(obj1,obj2) | min(obj1,obj2)  --  returns the "largest" or "smallest" of the two objects based on some default criteria
# max(obj1, key=func_name)  	   --  evaluates each item of 'obj1' using 'func_name' and returns the item deemed largest per function's criteria
# max(obj1, key=func_name)  	   --  evaluates each item of 'obj1' using 'func_name' and returns the item deemed smallest per function's criteria

deaths = {"Yael": 1, "Judith": 2, "Sampson": 4030, "Shamgar":600}
`
min(deaths, key=len) == 'Yael'										# find the shortest name
max(deaths.items(), key=lambda c: c[-1]) == ('Sampson', 4030)		# find who killed the most

# reversed( iterable )  --  Returns a reversed ITERATOR...a unique object that can be run to generate the reverse of the input tuple/string/bytes/bytearray.

tuple1 = (5,4,3,2,1)
tuple(reversed(tuple1)) == (1,2,3,4,5)

# len( obj )  --  This just calls the pre-defined obj.__len__() function "behind the scenes" 

len(obj) == obj.__len__()

# abs( numeric )  --  returns absolute value of numeric input
abs(-5.1)  == 5.1

# sum( numeric_iterable, start=add_to_sum )  --  returns sum of numeric values, plus optional add'l 'start' term to include
sum([2,4,6], start= -12) == 0
math.fsum( num_iter )			# Sums floats with extended precision

# round(number, ndigits=0)  --  round the provided number to the specified number of decimal places, default 0
round(2.7182818284, 3) == 2.718 

# zip( iterable1, iterable2, ...)  --  iterate through each list in parallel, and at each step group items with the same index into tuples.
#								   --  Return an ITERATOR of the tuples, with each tuple containing one item from each iterable.
#								   --  Stops when it reaches the end of any of the iterables.  (ignores the last elements of the longer iterables)

# NOTE: returns an iterator...may need to convert to list, tuple, dict, etc.
a = [1,3,5,7]
b = [2,4,6]
c = ['v','w','x','y','z']
list(zip(a,b)) == [(1,2,'v'),(3,4,'w'),(5,6,'x')]

five_by_two = [(0,1),(1,2),(2,3),(3,4),(4,5)]			# The * operator causes each element of list to be "unpacked" as separate input argument
list(zip(*five_by_two)) = [ (0,1,2,3,4), (1,2,3,4,5) ]		

isinstance(var_to_test, type)
isinstance('abc', str)	== True		

print()
input("Optional string here:")
if x==y: 
	x = x 			# MUST be 4 spaces indented 
elif x==z: x = x 
else:			


##############################
##### Classes
##############################

# Conventions
# 1. Class names should be singular
# 2. Class names in UpperCamelCase
# 3. Include an __init__(self): method UNLESS the class only contains methods and no data
# 4. Only use dunders 'self.__method__()' (double underscores) for defining "special" Python methods
# 5. Use single underscore 'self._private_var' to indicate a private variable
# 6. Place "special" and private methods first in class definition

# 7. Starting double underscore has a special meaning in Python
# !! any 'self.__method()' or 'self.__var1' will be "name mangled" to 'self._ClassName__method()' or 'self._ClassName__var1'
# !! these variable names indicate that they should be inherited by child classes.

class Parent(object):					# Defaults to base class 'object',
	def __init__(self, attr1, attr2):
		self.attr1 = attr1
		self.attr2 = attr2

	def method1(self, var1):
		return min(100,var1)


class Child(Parent):				# Input other class name to trigger inheritance

	class_attr = [1,2,3] 		# VERY RARE. Initialize "Class" attribute...global-ish. Shared by all instances, not specific to any instance.

	def __init__(self, var1=0, name1=''):				# Initialize instance attributes
		Parent.__init__(self, attr1, attr2)				# initialize the Parent class more directly
		# super().__init__(attr1, attr2, attr3, name1)	# An alternative way to Initialize parent using the "super()" function
		self._private_var = 'very private'			
		self.__inheritable = "I can be inherited"	
		self.attr3 = attr3 								# Instance attributes (public).  Accessible via 'instance_name.var1'
		self.name1 = name1
		local_var = 'only usable in __init__'			# a variable that is only scoped in the __init__() method.  Not accessible. 

	def __repr__(self):									# Manually control how instance is converted to str for 'print()' in ASCII format
		str1 = f"User object for {self.name}"
		str2 = f"var1: ({attr1})"
		return f"{str1}\n{str2}"

	def __iter__(self):									# Manually control what happens when iter(Child_instance) is called
		pass 

	def __next__(self):									# Manually control what happens when next(Child_instance) is called
		pass 

	def _private_func(self,attr3):					# Private instance method
		pass 

	def method1(self, attr3):		# !! DON'T FORGET 'self' when defining instance methods!
		pass

	@classmethod					# must include this decorator
	def class_method(cls):			# VERY RARE. the 'class' object is passed in by default, so 'cls' (or similar) must be included.
		pass 						# 

	@property						# MUST include this "decorator" when you want to create a property
	def private_var(self):			# this is the "get" method for the property
		return self._private_var	# can input custom logic here, but MUST return a private var

	@private_var.setter 				# MUST include this decorator for property "setter" function
	def private_var(self, value):		# This function handles when the property is written to.
		if value in range(121):			#
			self._private_var = value
		else:
			print("Erroneous value")		

	

# How to use classes

instance1 = Child()					# Instantiation of 'User' class object
class_attr = Child.class_attr		# To reference to the "global" Class variable
class_attr = instance1.class_attr	# DON'T do this.  Can access the single 'User.class_attr' object this way, but don't
									# the instance1.class_attr is a pointer to User.class_attr, BUT if you edit it..
									# it will CREATE a spearate instance attribute with the same name...very confusing	

attr3 = instance1.attr3 			# To reference an instance attribute
attr1 = instance.attr1				# Can also reference attributes of Parent class! (inheritance)
prop1 = instance.private_var 		# How to access a property
instance.private_var = 51			# How to write to a property

# Find the method resolution order for the class (with inheritance)
# What order will python traverse inheritance trees to find definitions of methods with the same name?
help(ClassName)			# Most readable 
ClassName.mro()			# Slightly readable
ClassName.__mro__ 		# Not very readable


	

##############################
##### Modules
##############################

# !! IMPORTANT:  When a module is imported, it is RUN!  Any code in the module will execute.

# If you create a module and want its code to ONLY run when it is executed directly....

if __name__ == '__main__':		# This is how a module can contain code that will be ignored when imported.
	code_to_run

import module_name
import module_name as new_name					# If you want to use a different name to access the functions within this file
												# Access functions as new_name.func_name()
from module_name import func_name1, func_name2	# Access functions as ONLY func_name1() -- do NOT use 'module_name.'
from module_name import func_name1 as f1

# AUTOPEP8

# from command line"
python3 -m pip install autopep8

autopep8 --in-place --aggressive <filename/path>
autopep8 -i -a <filename/path>


##############################
##### File I/O
##############################

file_object = open(	file=file_path,	# https://docs.python.org/3/library/functions.html#open
					mode='r', 		# 'r' reading, 'w' writing-truncating first, '+' reading & writing
									# 'a' writing-appending to end, 'x' exclusive create...fails if file already exists
									# 't' text mode, 'b' binary mode
					buffering=-1, 	# defaults to device block size (4096-8192 b), '0' no buffer binary mode only, '1' line buffering, 'other #' custom buffer size
					encoding=None, 	# defaults to result of locale.getpreferredencoding(), often 'utf-8'.  
					errors=None, 	# default None == 'strict' with ValueError for any failure, 'ignore' ignores all errors with data loss
									# 'replace' inserts character (e.g. ?) into malformed data, see docs for other options
					newline=None, 	# see docs for description
					closefd=True, 	# close OS file descriptor when read/write is complete
					opener=None)	# Very rarely used

# NOTES:
# 1. By default, 'w' '+' 'r+' starts at the BEGINNING of the file (thus overwriting contents)
# 2. In append mode, you lose control of the cursor...it always writes at the end
# 3. 'r+' will NOT create a file if it doesn't exist

# Files are read via CURSORS (SEEK)...as you read the file, the cursor (seek) moves.

# For TEXT filetype I/O
data_str = text_file_object.read(size=-1)		# READ: up to 'size' chars and return as a single string. '-1' is all available.  This moves the cursor.
data_str = text_file_object.readline(size=-1)	# READLINE: until newline or EOF and return a single str. If the stream is already at EOF, an empty string is returned.
data_list = text_file_object.readlines(hint=-1)	# READLINES: Read and return a list of lines from the stream. 
												# hint helps control the number of lines read: no more lines will be read if the total size (in bytes/characters) of all lines so far exceeds hint.
text_file_object.seek(offset, whence=SEEK_SET)	# SEEK: Change the stream position to the given offset. Returns the ending cursor position number
												# SEEK_SET or 0: seek from the start (default); offset must either be a number returned by TextIOBase.tell(), or zero.
												# SEEK_END or 2: seek to the end of the stream; offset must be zero
position_num = text_file_object.tell()			# TELL: Return the current stream position as an opaque number.
text_file_object.write(string)					# WRITE: the string s to the stream. Return the number of characters written.
text_file_object.writelines(lines_list)			# WRITE a list of LINES to the stream. Line separators are not added, 
												# so it is usual for each of the lines provided to have a line separator at the end.
text_file_object.close()						# CLOSE: Flush and close this stream. This method has no effect if the file is already closed.


# Alternate syntax "with ____" context manager 
# automatically __enter__()s and __exit__()s func/class after 'with'

with open(file="filename.txt", mode='+') as my_file:
	data = my_file.read()
	my_file.write(string1)
	# Using this syntax, __exit__() is called after context and the file is closed immediately.


##############################
##### CSV I/O
##############################

import csv

# Reader object are iterators, that iterate by ROW

# READER - use only lists, and access data only based on position index in list.
reader_object = csv.reader(csvfile=file_obj,		# READER allows you to iterate over rows and return a list of lists containing each row
						dialect='excel',
						delimiter=',',
						**fmtparams)
dialects_list = csv.list_dialects()

# DICTREADER - 
dictreader_object = csv.DictReader(f=file_obj,	# DICTREADER iterates over rows and returns OrderedDict containing each row with keys of "fieldnames"
									fieldnames=None,# By default, the first row of the file determines fieldnames
									restkey=None,	# Each row that has MORE elements than in "fieldnames", extra elements are put in a list, 
													# and that list of values is placed in the dict under the "restkey" key name
									restval=None,	# If a non-blank row has fewer values than normal, the missing values can be filled in with "restval"
									dialect='excel',
									*args, **kwargs)

# EXAMPLE - CSV READER iterables are ONE-TIME-USE! (They only iterate through once!)

with open("filename.csv") as file1:
	csv_reader = csv.reader(file1)
	header_row = next(csv_reader)		# Collect header row
	for data_row_list in csv_reader:
		# Insert action here for each data_row_list
		pass

with open("filename.csv") as file1:
	csv_dictreader = csv.DictReader(file1)
	# Headers are read automatically by DictReader
	for data_row_dict in csv_dictreader:
		# Insert action here for each data_row_dict, and OrderedDict data type
		pass

# WRITER
writer_object = csv.writer(csvfile=file_obj,
	 						dialect='excel',
	 						delimiter=',',
	 						**fmtparams)

# DICT
dictwriter_object = csv.DictWriter(f=file_obj,
									fieldnames,		# REQUIRED!, all the rest are optional and have defaults
									restval='',
									extrasaction='raise',
									dialect='excel',
									delimiter=',',
									*args, **kwargs)

# EXAMPLE - CSV WRITER

with open("filename.csv", mode='w') as file1:
	csv_writer = csv.writer(file1)
	csv_writer.writerow(["colheader1", "colheader2", "etc"])	# Must write header row manually
	for row_list in data:
		csv_writer.writerow(row_list)		# pass write data as list which will be str() formatted

with open("filename.csv", mode='w') as file1:
	fieldnames1 = ['field1name', 'field2name', 'etc']	# pass in as list or tuple (sequence)
	csv_dictwriter = csv.DictWriter(file1, fieldnames=fieldnames1)
	csv_dictwriter.writeheader()
	csv_dictwriter.writerow({"field1name": "If you want", "field2name": "you can specify manually"})
	for row_dict in data:
		csv_dictwriter.writerow(row_dict)	# pass write data as dict.  Values will be placed in appropriate named column


##############################
##### Pickling & JSONpickling --  Saving data within python applications to a file
##############################

# Note: PICKLE only useful for python-python data transfer.  Not human-readable, not easily transferable.

import pickle

# To SAVE:
pickle.dump(obj=(data, to, save),	# Multiple objects can be combined in a tuple
			file=file_object,
			protocol=None,
			fix_imports=True,
			buffer_callback=None)

# Return raw binary instead of writing directly to file.
bytes_obj = pickle.dumps(obj, protocol=None, *, fix_imports=True, buffer_callback=None)

# To LOAD: pickle.load(file_obj)
data = pickle.load(file=file_obj,
					fix_imports=True,
					encoding='ASCII',
					errors='strict',
					buffers=None)

# Reconstruct original object from pickled bytes object
original_data = pickle.loads(data=pickled_data_bytes, /, *, fix_imports=True, encoding="ASCII", errors="strict", buffers=None)¶

# Example
with open("saved_prog_data.pickle", mode = 'wb') as file_obj:	# "Pickling" generates binary, so 'b' must be used
	pickle.dump((data1, object1, whatever), file_obj)			# can include multiple objects as tuple
with open("saved_prog_data.pickle", mode='rb') as file_obj:
	(data1, object1, whatever) = pickle.load(file_obj)


### JSONpickle --------------------

import jsonpickle

# To convert to JSON
json_version = jsonpickle.encode(value=any_object,
								make_refs=True, 	# If False, Objects that are id()-identical won’t be preserved across encode()/decode(). 
													# jsonpickle detects cyclical objects and will break the cycle by calling repr() instead of recursing.
								keys=False, 		# Set to TRUE if obj contains Dict with non-string keys!!
								max_depth=None, 	# Recurse only 'x' levels deep into any object  
								warn=False, 		# If True, will warn when it returns None for an object which it cannot pickle (e.g. file descriptors).
								max_iter=None, 		# If set to a non-negative integer then will consume at most max_iter items when pickling iterators.
								indent=None,		# Indent level for pretty-printing array elements and object members. '0' only newlines. None is most compact.
								and_more)

original_version = jsonpickle.decode(string, 		# Data read from file
									backend=None, 	
									keys=False, 	# If True, will decode non-string dictionary keys into python objects via the jsonpickle protocol.
									safe=False, 
									classes=None)  	# set to a single class, or a sequence (list, set, tuple) of classes to give access to local classes 
													# that are not available through the global module import scope.

# By default, jsonpickle will try to use, in the following order: simplejson, json, and demjson
jsonpickle.set_preferred_backend(name)		# Use this if a different version is preferred.	

# Example: JSONpickle

with open("filename.json", mode='w') as file:
	frozen = jsonpickle.encode(data_object)
	file.write(frozen)

with open("filename.json") as file:
	contents = file.read()
	unfrozen = jsonpickle.decode(contents)
	

##############################
##### Error Handling
##############################

# Exception: generic name

# NameError: when variable isn't defined...i.e. is referenced before it is defined, or referencing out-of-scope variable

# TypeError: operation or function applied to the wrong type.  Python can't interpret operation on two data types.
len(5)	# TypeError

# IndexError: upon attempt to access an element out of the valid index range of a string, list or tuple
name = "Verigo"
name[6]  # IndexError

# ValueError: when built-in operation or function receives an arg with correct type, but invalid value
int('10')  # okay
int('foo') # NOT okay

# KeyError: like IndexError, but for dicts.  Trying to reference a key that doesn't exist in dict.
dict1 = {}
dict1["foo"]  # KeyError

#AttributeError: when you try to reference a property, attribute, or built-in function of an element that does not exist.
[1,2,3].keys()		# AttributeError.  Lists don't have keys...only dicts have keys

raise ValueError("Your custom error message")	# "raise" can be used with any Error, built-in or custom.

# Minimal
try:
	enter_code_here
except:
	exception_handling_here

# Comprehensive
try:
	enter_code_here
except NameError as name_error_string:
	name_exception_handling_here
except (TypeError, IndexError) as error_string:
	exception_handling_here
else:
	runs_if_no_error
finally:
	always_runs



##############################
##### Testing (Test Driven Development)
##############################\

# Red, Green, Refactor
# Write Test first, then run test and it will fail -- Red
# Write MINIMUM amount of code to make test pass   -- Green
# Go back and clean up the code to make it more workable, and then ensure that the test still passes.

# ASSERTIONS -- A handy way to insert a test in code that should be TRUE
# 			 -- will be silent if True, but will raise AssertionError and optional message if False.
#			 -- NOTE: All assertions will be IGNORED if the program is run in "optimized mode": "py -O program.py"
x = 51
x = 51
assert x == 50, "x should be 50, but is not"


### UNITTEST Module -- built-in structure for creating unit tests in Python
#					-- groups of tests are encapsulated as classes that inherit from unittest.TestCase
#					-- Create separate Python file containing tests that imports the code you want to test
#					
# 					-- Run "tests" file (see format below)
#					-- https://docs.python.org/3/library/unittest.html

# Procedure

# 1. Create separate "test" Python file that imports the code you want to test, add boilerplate
# 2. Create a new SomeTests Class that inherits from unittest.TestCase
# 3. If necessary, define setUp() functionality to run before every test method
# 4. If necessary, define tearDown() functionality to run after every test method
# 5. Create each specific test as a separate method of this SomeTests Class
# 6. Run this new tests file

# Common Tests

# self.assertEqual(a,b)		-- if a == b, test passes
# self.assertNotEqual(a,b)	-- if a != b, test passes
# self.assertTrue(a)		-- if a is Truthy, test passes 
# self.assertFalse(a)		-- if a is Falsy, test passes
# self.assertIsNone(a)		-- if a == None, test passes
# self.assertIsNotNone(a)	-- if a != None, test passes
# self.assertIn(a,b)		-- if (a in b), test passes
# self.assertNotIn(a,b)		-- if (a not in b), test passes

# tests.py Example File

import unittest
from file_to_test import func1, func2

class UnitTests1(unittest.TestCase):

	def setUp(self):
		"""Insert any code you want to run BEFORE EVERY test method"""
		pass

	def tearDown(self):
		"""Insert any code you want to run AFTER EVERY test method"""
		pass 

	def test_func1_scenario1(self):									# Define the first test
		"""Describe this test here"""
		self.assertEqual(func1(arg1a, arg2a), expected_return_a)	# Use the assertEqual built-in tool to test that two values are equivalent expected return with known input args

	def test_func1_scenario2(self):									# Define a second test
		"""Describe this test here"""
		self.assertNotEqual(func1(arg1b, arg2b), NOT_return_b)		# Use assertNotEqual to test that two values are NOT equivalent
		self.assertNotNone(func1(arg1b, arg2b))						# And verify that something is returned

	def test_func2_scenario1(self):
		"""Verify that a scenario raises a specific Error"""
		with self.assertRaises(ValueError):							# Verify that a particular scenario raises a particular Error type
			func2(arg1c, arg2 = wrong_type_var)

	def test_func

if __name__ == "__main__":
	unittest.main()


# DOCTESTS	-- An older, clumsy built in means to include tests within the docstring
#			-- WARNING: Extremely fragile to syntax of the tests written.
#			-- https://docs.python.org/3/library/doctest.html

# Command
python3 -m doctest -v file_to_run.py

# EXAMPLE
def average_with_tests(*args):
	""" A function that returns an average/mean of the input arguments.
	Input arguments must only contain all string or all numeric data types.  
	If the input arguments are strings or lists/tuples of strings, then each character will be evaulated to it's numerical ASCII equivalent,
	and the character of the average ASCII value will be returned.
	If the inputs are numeric or lists/tuples of numerics, it will return the arithmetic mean of all of the numeric values.
	Tests are included below in the docstring.

	>>> average_with_tests()
	
	>>> average_with_tests(1,2,3,4,5)
	3.0
	>>> average_with_tests([1,2,3], [4,5,6], [7,8,9,10])
	5.5
	>>> average_with_tests(["a", "b", "c"])
	'b'
	>>> average_with_tests("abcde", "fghij")
	'f'
	>>> average_with_tests(1,"a")
	Traceback (most recent call last):
	...
	ValueError: Input arguments must contain either all strings or all numeric values.
	"""

	if not args:
		return None
	elif all( [ all([type(item) in (int, float, complex) for item in arg]) if (type(arg) in (list,tuple)) else (type(arg) in (int,float,complex)) for arg in args]):
		sum1 = 0.0
		count = 0
		for arg in args:
			if type(arg) in (list,tuple):
				for num in arg:	
					sum1 += num
					count += 1
			else:
				sum1 += arg
				count += 1
		mean = round(sum1/count, 3)
		return mean 

	elif all( [ all([type(item) == str for item in arg]) if type(arg) in (list,tuple) else type(arg) == str for arg in args]):
		list1 = []
		for arg in args:
			for char in arg:
				list1.append(float(ord(char)))
		avg = int(round(sum(list1)/len(list1)))
		return chr(avg)

	else:
		raise ValueError("Input arguments must contain either all strings or all numeric values.")


##############################
##### Debugging with PDB (Python Debugger)
##############################

import pdb; pdb.set_trace()		# Sets a breakpoint wherever "pdb.set_trace()" is provided in code 

# Common PDB Commands:
# h 			(print a list of available commands)
# h pdb			(show full pdb documentation)
# l <opt_num>	(list source code around current location)
# ll 			(list source code of whole current function or frame)
# n 			(execute entire next line)
# s 			(step, execute the minimum possible, stopping ASAP)
# p <expr> 		(print the value of <expr>)
# pp <expr>		(pretty-print the value of <expr>)
# w 			(print a stack trace, with the most recent frame at the bottom)
# c 			(continue running until next breakpoint)
# b 			(list all breakpoints)
# b <num>		(set breakpoint at line # <num>)
# unt <num>		(continue execution until reach a line # > num)
# q 			(force quit immediately)

# pdb.set_trace()  --  Critical function that pauses execution wherever it is placed

# To view the value of a variable with name ('l','a',)


##############################
##### Timing Operations in Python (with "time" module)
##############################
import time

start_time = time.time()
insert_operation_here()
end_time = time.time()

time_elapsed = end_time-start_time

# Or via a "decorator"
from functools import wraps

def speed_test(func):
	@wraps(func)
	def wrapper(*args, **kwargs):
		print(f"Executing {func.__name__}")
		start_time = time.time()
		result = func(*args, **kwargs)
		end_time = time.time()
		print(f"Time Elapsed: {end_time-start_time}")

		return result
	return wrapper

# With the speed_test decorator before the function definition, the speed test will always be called for the function.
@speed_test
def func_to_test(*args):
	# Insert code here
	pass 

func_to_test()	# This will be called wrapped in speed_test()
