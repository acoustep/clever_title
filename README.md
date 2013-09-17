# clever\_title

Clever\_title is my attempt at making titles with relatively accurate capitalisation for the English language.

## Usage

Include clever_title in the class of your choosing like so.

```
require 'clever_title'

class String
  include CleverTitle
end
```

Call it on the string of your choice.

```
"hello world".clever_title
=> "Hello World"
```

There is a list of common conjunctions and prepositions that will be kept as lowercase.  When running clever_title you can set the maximum amount of letters in a word that will be made lowercase by adding the hash ```:max_downcase_conversion``` like so

```
clever_title = "Cornelius provided the man ABOARD the boat WITH TWO FISH".clever_title max_downcase_conversion: 4
=> "Cornelius Provided The Man Aboard The Boat with Two Fish"
```

Notice how "aboard" is capitalised where as "with" is not.

## To do

* Test and implement usage with arrays / hashes (including looping through a list of them)
* Check for periods and force capitalise next word.
* Allow a list of words that must either be converted to all uppercase or remain as all uppercase if already set.

## Code Status
[![Gem Version](https://badge.fury.io/rb/clever_title.png)](http://badge.fury.io/rb/clever_title) 
[![Build Status](https://travis-ci.org/acoustep/clever_title.png?branch=master)](https://travis-ci.org/acoustep/clever_title)
