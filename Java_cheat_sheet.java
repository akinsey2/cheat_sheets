// Write Once, Run Anywhere (WORA), platform independence via Interpreter
// Almost as fast as C
// Automatic "Garbage Collection" - No Manual Memory Management required

// Netscape Navigator shipped with Java in 1996

// Platform dependency due to compilation to processor-specific machine code AND System (OS) Calls

// Interpreter: a virtual machine (program) that simulates a CPU
//    - references "libraries" of compiled machine code
//    - converts compiled Java byte code to the machine code for the processor in question

// Java Virtual Machine (JVM) ... the Interpreter.
//    - Generally, one instance of JVM for each Java program
//	  - JVM is loaded into memory along with the program to be run

// ".class" files - "compiled" Java bytecode files executed by JVM

// Java SE (Standard Edition, J2SE): The "core". For standalone applications on desktops and servers
// Java EE / Jakarta EE (Enterprise Edition, J2EE): for large-scale server applications, many users across many servers.  Extension of Java SE.
// Java ME (Micro Edition, J2ME): small, resource constrained (edge, IoT) devices.  Subset of Java SE.

// Java SE Specifications:
// 		- JLS: Java Language Specification - syntax and semantics
//		- JVMS: Java Virtual Machine Specification - defines JVM and Java bytecode specification
//
//		- Java API Specification: (Java Development Kits, JDKs, Java SDKs)
//			- Oracle JDK (canonical, but $$)
//			- Oracle OpenJDK
//			- Adopt OpenJDK
//			- Amazon Corretto
//			- Red Hat's OpenJDK

// Java Virtual Machine (JVM) Implementations:
//		- HotSpot JVM (Oracle, OpenJDK)
//		- OpenJ9 JVM (Eclipse Foundation)
//		- Among Others


// ---  General Requirements ---

// - For every program / library, there is a .java file, which contains (ONE) class.
// - The top class of every .java file MUST contain a "main()" method
// - The .java file is compiled into a .CLASS file with the same name as the class 
// - The .JAVA file, the class name, and the .CLASS filename should all match.

// ---	Naming Conventions ---

// - ALL identifiers MUST start with a letter, "_", or "$"
// - CLASS names: begin with an Uppercase Letter, then CamelCase
// - OBJECT names: begin with a lowercase letter, then CamelCase


// Single line comment
/* Multi
	Line
	Comment */


//---------------------------------------------	
// --- Important Notes ---
//---------------------------------------------

/*

- At the CLASS level, you can only have DECLARATION statements.
- At the CLASS level, Expressions and Control Flow statements are NOT ALLOWED.
- Expressions and Control Flow statements MUST be in METHODS or other class-level declarations.

- Non-primitive types are called "Reference" types...they are accessed by a pointer reference.
- Constructors always return a REFERENCE to the new object.
- Objects are passed by REFERENCE in java...the Object's variable actually contains the REFERENCE

- Deep Copying must be done with a loop or System.arraycopy.

- Java methods only return ONE variable.  You must use an Object to return multiple variables.

- OVERFLOWs occur silently in primitive data types.

- 1/0 yields runtime Exception, while 1.0/0.0 yields INFINITY.

- Integer divide rounds TOWARD ZERO.

- Integer Modulus a % b : implemented to maintain a = (a/b)*b + (a % b)
- -14 % 3 = -2 while 14 % -3 = 2.

- Variables in a for() loop header have scope ONLY to the loop.

- Static methods CANNOT take other static methods as arguments in Java.

- All NON-Static method invocations are associated with an object 

*/


//---------------------------------------------	
// --- General Architecture Guide ---
//---------------------------------------------

/*

OOP:
 - A Data Type is a set of values and a set of operations defined on those values.
 - An Object is an instance of a data type.

- Most Java programs (Classes) are either
	1. (Static) Libraries of Static Methods, or
	2. (Instance) Data Type Definitions

- Literal: something that is compiled into a constant
	- Examples: 1, -42, 2.998e8, true, 'a'

- Expression: a sequence of operations on literals and variables that evaluates to a value.

- EVERY Java STATIC class should include at least one "main()" method (can have multiple) 
	that contains tests to "exercise" the methods in the library and provides some assurance of functionality.

- Static Methods: primary purpose is to implement functions.

- Non-Static Methods: primary purpose is to examine or change data (state) in Data Type.

- Objects
	- Non-static classes typically are Data Type Definitions, or Abstract Data Types, and hold data
	- Instances of Objects have:
		- State
			- Data they contain
		- Identity
			- Their unique reference, stored in the instance variable.
		- Behavior
			- Instance methods...operate on Data/State values

*/

//---------------------------------------------	
// --- Overview of Java Libraries ---
//---------------------------------------------


// --- java.lang --- 

/* "Boxing" Classes */ Boolean, Byte, Character, Double, Float, Integer, Long, Short

Number;		// superclass of classes BigDecimal, BigInteger, Byte, Double, Float, Integer, Long, and Short.

Object;		// Class Object is the root of the class hierarchy.

String;		// The String class represents character strings.
StringBuffer;
StringBuilder;

Class<T>;	// Instances of the class Class represent classes and interfaces in a running Java application.

Math;		// Library of methods for numeric operations such as exponential, logarithm, square root, and trigonometric functions.

StrictMath; // ! use only primitive types ! methods conforming to netlib's fdlibm and "IEEE 754 core function" versions

System;		// contains several useful class fields and methods.
Process, ProcessBuilder, ProcessBuilder.Redirect;

Character.Subset, Character.UnicodeBlock

/* 27 Exceptions, including */ 
Exception, ArithmeticException, ArrayIndexOutOfBoundsException, ArrayStoreException, NegativeArraySizeException,

IndexOutOfBoundsException, StringIndexOutOfBoundsException, IllegalArgumentException, NullPointerException, 

NumberFormatException, UnsupportedOperationException


// --- java.util Interfaces, include --- 

Collection<E>;
Comparator<T>;
Iterator<E>;
Queue<E>, Deque<E>;
List<E>, ListIterator<E>;
Map<K,V>, NavigableMap<K,V>, SortedMap<K,V>;
Set<E>, NavigableSet<E>, SortedSet<E>;


// --- java.awt, include --- 

java.awt.Color, java.awt.Font

// --- java.net, include ---

java.awt.URL 

// --- java.io, include --- 

java.io.File


//---------------------------------------------	
// --- Variables ---
//---------------------------------------------

// - STATICALLY TYPED: Variable Types are FIXED at instantiation, and CANNOT be changed.
// - All variables must be DECLARED before use (declaration statement)
// - After instantiation, variable values CANNOT be reassigned at class level 

// - STATIC variable: defined at high-level def of class, only ONE which belongs to "class" and not any specific instance/object
//		- Scope: Entire Class
//		- Have default values
//		- Cannot be re-initialized directly within class

// - INSTANCE variable: defined at high-level def of class. A unique var created for each object/instance of class 
//		- Scope: Available to all methods of class
//		- Have default values
//		- Accessible from outside scope of class via object reference.
//		- Cannot be re-initialized directly within class

// - LOCAL variable: defined within a method.
//		- Scope: Within method only
//		textbooks

class ClassOne {
	static int instance_count;	// Static var...only 1 total, gets default value

	int property1;				// Instance vars...1 created per object/instance
	char property2 = 'A';

	void myMethod1(){
		int x = -42;			// Local var, NO DEFAULT...must be defined
	}
}

// --- Multivariable Declaration ---

// - All variables declared on one line must have the same type.

// - CAN do
int x=1, y=2, z=3;
double pi=3.14, e=2.718;

// - CANNOT do
int x=1, char y='A', double=3.14;


//---------------------------------------------	
// ---	The 8 Primitive Data Types ---
//---------------------------------------------	

boolean x = (true || false);	// 1 bit
char x = ('B' || '\u0042'); 	// 2 byte unsigned integer internally, default 0 := NULL 

byte x = 0b01010101;	// 1 byte int, -128 to 127
short x = 0xFFFF;	// 2 byte int, -32768 to 32767
int x;		// 4 byte int, -2^31 to 2^31 - 1
long x; 	// 8 byte int, -2^63 to 2^63 -1

// IEEE 754 - Imperfect precision!

float x = 3.6f;	// 4 byte float, ~6-7 digits precision, +/- 3.4e38 
// Java assumes all decimal numbers are "double" by default.  Must use "f" to override to float for declarations.
double x = 2.99792458e8; 	// 8 byte float, ~15 digits precision, +/- 1.7e308


// --- Other Data Types ---

// Item 48: Avoid float and double if exact answers are required. 

BigDecimal money = new BigDecimal("3.179")	// Slow calculations, but perfect precision


// --- Type Casting ---

// -- Converting from a SMALLER to LARGER variable type size happens automatically.  No need to specify anything.
// AUTOMATIC Widening: 
byte -> short -> char -> int -> long -> float -> double

// Converting from LARGER to SMALLER variable size must be done manually.
// NOT automatic:
double -> float -> long -> int -> char -> short -> byte

long longer = 299792458l;
int shorter = (int) longer;

byte narrowdByte = (byte) 123456;	// Information loss due to out-of-range assignment
int iTruncated = (int) 0.99;		// Truncation

// Converting to 'char' must always be EXPLICIT
byte num = 65;
char letterA = (char) num;


//---------------------------------------------	
// ---	Variables: Object References, Arrays ---
//---------------------------------------------	

// In Java, all Object data is stored on the HEAP.

Student s; 					// prototype declaration gives 's' a DEFAULT value of NULL. A null reference.
Student s = new Student();	// 's' is an object reference to the newly created object of the Student class.

int[] array1;					// prototype declaration of reference.
int[] array1 = new int[100];	// Initialize array object of explicit size, with default values (0)
int[] array2 = {1,2,3,4,5};		// Initialize new array object with explicit values
array2.length;					// Access array object field showing the size

// Array indeces MUST be 0 to n-1
array2[0], array2[4];		// Valid
array1[-1], array2[5];		// NOT Valid

// This does NOT work
int[] array1;
array1 = {1,2,3,4,5};		//
// Due to a weird syntactic rule, after a variable is already declared, you must use...
array1 = new int[]{1,2,3,4,5};

// -- 2D arrays

int[][] array1;
int[][] array1 = new int[5][10];	// initialize 2D array specific size, default values.
// Actually, each array[i] simply contains an object reference to a 1D array[10].
int[][] array2 = { {1,2}, {3,5}, {7,11}, {13,17}};

num_rows = array2.length;
// Each column of 2D array can have DIFFERENT SIZES in Java!

int[][][] surface_heat = new int[100][100][100];
// int[i] is an object reference to a 2D array object.
// So surface_heat contains a hierarchy of object references
// int[i] contains obj ref -> 2d array, which contains obj refs -> 1d array


//---------------------------------------------	
// ---	Methods ---
//---------------------------------------------	

// Take input (Parameters), contain logic/processing, produce output (return)

// !!Reference objects passed into method CAN & WILL be changed outside the scope of method.

[public || private] [method type] [output type] method_name (int param1, float[] param2) {}

// --- Instance Methods ---

class Class_Name {	
	public void method1() {}
}
Class_Name instance1 = new Class_Name();
instance1.method1()

// - Object-level methods, specific to that object instance
// - Manipulate the instance variables of that object instance
// - Typically change the state of that object instance 
// Invoked 


// --- Static Methods ---

class Class_Name {
	public static void method1(){}
}
// - Class-level methods.  Typically "utility methods".
// - Do NOT have access to any instance variables
// - Do NOT impact the state of any particular object instance
// Invoked via:
Class_Name.method1();


// --- Constructors ---

// - Are called any time an instance of a Class is created.
// - Serve to initialize the state of the instance object.
// - CANNOT return a value
// - CAN invoke other methods

// - If one is not specified, the compiler will insert a "no-args Constructor" for you.
Class_Name() {}

// To create a useful one....
class Class_Name {

	int var1, var2;
	char sym1;

	Class_Name(int i1, int i2, char s1) {
		var1 = i1;
		var2 = i2;
		sym1 = s1;
	}
}

//---------------------------------------------	
// !!! --- HIDING / SHADOWING of instance variables
//---------------------------------------------	

// - If the parameters are given the same names as the instance variables, they will create LOCAL variables of that name
// - These LOCAL variables will "hide" the instance variables, and hinder access of the instance variables
// - To fix, 
//		1. just change your parameter names so they don't "collide" with the instance var names
//		2. use the "this" keyword to access INSTANCE variables.

class Class_Name {

	int var1, var2;
	char sym1;

	Class_Name(int var1, int var2, char sym1) {
		this.var1 = var1;						
		this.var2 = var2;						// "this." is a ref to INSTANCE var of that name
		this.sym1 = sym1;						// The plain name refs the LOCAL variable of that name.
	}
}



//---------------------------------------------	
// --- IMPORTANT: Passing data & Variable Scope ---
//---------------------------------------------	

// - In Java, when a PRIMITIVE variable is passed into a method, it becomes a LOCAL-only variable.
// - No state outside of the method is changed

void method1(int i) { i++ }

int i1 = 1000;	// a PRIMITIVE.
method1(i1);	// The method operates on the VALUE-only of the primitive.  It does NOT change state of original primitive.
i1 == 1000;  // TRUE.  The method created a new var 'i' with local scope.  'i1' is unchanged

// - In Java, when an OBJECT reference is passed into a method, the method CAN change the outside state of the object.

void method2(int[] i) {i[0]++}

int[] i2 = {1000};  // an OBJECT.
method2(i2);		// The method operates directly on the object, and changes its state
i2 == {1001};	// TRUE.  The method increments 'i2' !!!


//---------------------------------------------	
// --- Method Overloading ---
//---------------------------------------------	

// - Defining a method with the SAME NAME, 2+ different ways
// - Parameter lists MUST be DIFFERENT  (that is how they are distinguished during use)
// - Parameter types and order are used for delineation (method binding) at compile time (return type is NOT used)

int AddOne(int i) { return i+1; }				// Definition 1
String AddOne(String s) { return (s + "One"); }	// Definition 2

int i1 = 0;
String s1 = "Zero";

i1 = AddOne(i1);	// Same function called, different results.
s1 = AddOne(s1);


//---------------------------------------------	
// --- VarArgs --- Variable length arguments
//---------------------------------------------	

// - MUST be the LAST (or only) parameter of the method.
// - Allows you to pass 0 or more arguments via the VarArgs
// - ellipsis is the key syntax
// - Creates an array

void method1(char c, int... num_list) {
	if(num_list.length) {
		num_list[0];	// Do something
		num_list[1]; 	// Do something
	}
}



//---------------------------------------------
// --- Operator Precedence  (highest to lowest)
//---------------------------------------------

. 									// Access object member
(expressions...),					// parenthesized expression
[expressions...]
------------------------------
++, --								// unary post-increment or post-decrement
------------------------------
++, --								// unary pre-increment or pre-decrement
+, -								// unary plus or minus
!, ~								// unary logical NOT or bitwise NOT
------------------------------
()									// cast
new									// object creation
------------------------------
*, % 								// Multiply, modulo
------------------------------
+, - 								// Add and subtract, numerical
+ 									// String concatenation
------------------------------
<<, >>, >>>							// Shifts
------------------------------
<, <=, >, >=, instanceof			// relational comparisons
------------------------------
!=, ==								// equality comparisons
------------------------------
&									// Bitwise AND
------------------------------
^									// Bitwise XOR
------------------------------
| 									// Bitwise OR
------------------------------
&&									// Logical AND
------------------------------
|| 									// Logical OR
------------------------------
?:		 							// Ternary
------------------------------
 =, +=, -=, *=, /=, %=,				// Assignment operators
&=, ^=, |=, <<=, >>=, >>>=			
------------------------------


//---------------------------------------------
// --- Loops
//---------------------------------------------

// WHILE

// FOR

// FOR EACH -- Object must have an iterator


for ()		// Shorthand



//---------------------------------------------
// --- Iterators
//---------------------------------------------

// An ITERABLE is any class with a method that returns an Iterator.

public interface Iterable<Item> {
	Iterator<Item> iterator();
} 

public interface Iterator<Item> {
	boolean hasNext();
	Item next();
	// void remove();	// use at your own risk
}

//Example - Implement iterable stack using linked list "Node" class
public class Stack<Item> iterator() { return new ListIterator(); }

private class ListIterator implements Iterator<Item> {

	private Node current = first;

	public boolean hasNext() 	{ return current != null; }
	public void remove();		{ /* Choosing not to support */}
	public Item next() {
		if (current == null) { 
			throw new NoSuchElementException;  
			Item i = null;
			return i; }

		Item item = current.item;
		current = current.next;
		return item;
	}
}


//---------------------------------------------
// --- Strings
//---------------------------------------------

// Java natively uses UTF-16 for character and String encoding 

// Java strings are actually objects

String s1 = "String contents";
String s2 = " and some more";

// and have many operators

s1 + s2					// String concatenation

s1.length()
s1.toUpperCase()
s1.toLowerCase()
s1.indexOf("g") --> 5	// returns index of first occurence of specified string


//---------------------------------------------
// --- Arrays
//---------------------------------------------


//---------------------------------------------
// --- Lists
//---------------------------------------------


//---------------------------------------------
// --- "Comparable" interface
//---------------------------------------------

// Older method, defined in java.lang
// Defined within the class of the new data type itself.
// Enables comparisons/sorting via a SINGLE logical method

// implements "compareTo() method"

class Movie implements Comparable<Movie>
{
	// other class variables/methods....and then

	public int compareTo(Movie m) { return this.year - m.year; }
}

results = Movie1.compareTo(movie2);

if (movie1 > movie2) { return 1; }
else if (movie1 < movie2) { return -1; }
else if (movie1 == movie2) { return 0; }

// 

//---------------------------------------------
// --- "Comparator" interface
//---------------------------------------------

// Newer method, defined in java.util
// Defined separately from the class of the new data type.
// Enables sorting via a MULTIPLE methods/characteristics

// Allows you to create a "sorting definition" object to pass into ".sort()" methods

public static final Comparator<Student> BY_SECTION = new BySection();
public static final Comparator<Student> BY_SECTION = new ByName();

private static class BySection implements Comparator<Student>
{
	public int compare(Student a1, Student a2)
	{ return a1.section - a2.section}
}

private static class ByName implements Comparator<Student>
{
	public int compare(Student a1, Student a2)
	{ return a1.name.compareTo(a2.name); }	// Utilizes built-in String "Comparable" interface
}

result = BySection.compare(student1, student2);

if (student1 > student2) { return positiveNum; }
else if (student1 < student2) { return negativeNum; }
else if (student1 == student2) { return 0; }

