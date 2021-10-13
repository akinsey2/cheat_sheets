# Beautiful Soup Cheat Sheet

# py -m pip install bs4
# py -m pip install lxml

from bs4 import BeautifulSoup
import requests

soup = BeautifulSoup(markup='', 		# Can be a string or open file handle.
					features=None, 		# Can be the name of a specific parser OR the type of markup to be used ('html', 'html5, 'xml')
										# default is 'html.parser', 'lxml' (for html) is better parser if installed,
										# lxml-xml' is good parser for XML if installed
										# 'html5lib' parser is slow, but creates valid html5 if installed
					builder=None,		# Only used for custom TreeBuilder implementations
					parse_only=None, 	# a SoupStrainer object, only matching parts of object will be considered
					from_encoding=None, # specify an explicit encoding if BeautifulSoup is guessing wrong
					exclude_encodings=None, # a list of strings indicating encodings known to be wrong
					and_others)

# Retrieve the html contents as string
with open("filename.html") as file1:
	soup = BeautifulSoup(file1, features='lxml')

# Or input the html string directly into BeautifulSoup to parse
with open("filename.txt") as file1:
	html_doc_str = file1.read()
	soup = BeautifulSoup(html_doc_str, features='lxml')

# Or retrieve from requests module
url1 = "https://www.barnstormers.com/listing.php"
html_doc = requests.request(method='GET', url=url1)

soup = BeautifulSoup(html_doc_str, features='lxml')

# "SOUP" Object - a tree structure containing all elements of the html file as bs4 custom sub-objects 

# The overall SOUP object can be printed
print(soup)
print(soup.prettify())

# And the sub-objects can be printed as well.
print(soup.title)

# Navigation sub-objects by the tag type
# This will always select the FIRST example of the sub-object in each level.
soup.title
soup.title
soup.title.name
soup.title.string
soup.title.parent.name
soup.p
soup.p['class']
soup.a

# FIND always returns BeautifulSoup Tag sub-object(s)

obj = soup.find('a')					# Find only first instance of sub-object containing search string
list1 = soup.find_all('a')				# Returns list of all instances of sub-objects containing search string
obj = soup.find(id="link3")				# Can also search based on attributes (IDs should only be used once in html)
list1 = soup.find_all(class_="special")	# MUST include underscore when searching based on html "classes" 
list1 = soup.find_all(attrs={"data1": "yes"})	# Can also search based on attributes (e.g. src="img_path", href="link", etc)

# SHORTCUT for .find_all('a')
soup('a')

# find an element with an id of foo
soup.find(id="foo")
soup.select("#foo")[0]

# find all elements with a class of bar
# careful! "class" is a reserved word in Python
soup.find_all(class_="bar")
soup.select(".bar")

# find all elements with a data attribute of "baz" using the general attrs kwarg
soup.find_all(attrs={"data-baz": True})
soup.select("[data-baz]")

# Navigating via CSS Style SELECTor (always returns a LIST of the soup sub-objects)

# Select by id: #foo
# Select by class of bar: .bar
# Select children: div > p
# Select descendents: div p
list1 = soup.select("#first")		# equivalent to [soup.find(id="first")]
list1 = soup.select(".special")		# equivalent to soup.find_all(class_="special")
list1 = soup.select("div")			# equivalent to soup.find_all('div')
list1 = soup.select("[data1]")		# similar to soup.find_all(attrs={"data1": })

soup.get_text()			# Extracts all plain-text in the document


##############################################
# Or, often FIRST search for specific elements,
# and THEN only extract the text from those elements.

# After FINDING and SELECTING, accessing data in elements

# .get_text()
text_str = soup.find(id='foo').get_text()			# Retrieve the plain-text associated with one element.
text_str = soup.get_text(element)				# Returns empty string if none present.

# .attrs and .attrs()
attr_dicts = soup.find(id='foo').attrs			# Returns dicts of all attributes associated with that element
attr_dict = soup.attrs(element)					# Return dict(s) of all http attributes of element
												# e.g. [ {"class": ["class1name", "class2name"]}, {"other_attr": "other value"} ]
attribute_value = soup.find_all("h3")[0]["class"]		# also will return value of an attribute if you have the key
attr_list = id_soup.p.get_attribute_list('id')	# to get a value that’s always a list, whether or not it’s a multi-valued attribute


# 
html_tag_name = soup.find(id="foo")



http_tag_name_str = soup.name(element)	# 'div', 'table', 'span', 'a', etc

###########################################
# Navigating Trees

# Nested tag elements can easily be traversed via the intrinsic tree structure of BeautifulSoup objects

### Going DOWN ---------

# Return a LIST of all objects ONE level down within a section...Tag sub-objects
all_body_elements_list = soup.body.contents		# Can use for 'body', 'div', 'table' etc

# or return a GENERATOR of all objects ONE level down within a section
all_subelements_generator = soup.body.children	# same as '.contents', but returned as a generator

# Return a LIST of all objects ALL levels down within a section...all Tag sub-objects
all_body_elements_list = soup.body.contents		# Can use for 'body', 'div', 'table' etc

# At the lowest level, only a string (NavigableString) remains as sub-object
low_level_NavigableStr = soup.find(id="foo").string
low_level_str = str(soup.find(id="foo").string)

# Retrieve all strings within an object
all_NavigableStrs = soup.strings
for string in soup.strings:
	print(repr(string))

# Retrieve all strings with whitespace stripped:
all_NavigableStrs_rem_white = soup.stripped_strings
for string in soup.stripped_strings:
	print(repr(string))


### Going UP ---------

# Retrieve one level up
head_tag = soup.title.parent

# Traverse and retrieve all tag levels up to top of doc
parents_hier_list = tag.parents
for parent in tag.parents:
	print(parent)


### Going SIDEWAYS ---------

# Retrieve next and previous tag on the same level of the hierarchy, if it exists, or return None
# NOTE: Nearly always must use TWICE to skip over the whitespace object
sibling_soup.b.next_sibling.next_sibling
sibling_soup.c.previous_sibling.previous_sibling

# Traverse and retrieve all siblings
for sibling in soup.a.next_siblings:
    print(repr(sibling))

for sibling in soup.find(id="link3").previous_siblings:
    print(repr(sibling))

### Going Sequentially through all elements
last_a_tag.next_element
last_a_tag.previous_element

for element in last_a_tag.next_elements:
    print(repr(element))

for element in last_a_tag.previous_elements:
    print(repr(element))