SC_Paternuum
============

Livecoding fronted to SuperCollider server


Demo
----
* [vimeo](https://vimeo.com/47719760/)


Requirements
------------
* [SuperCollider](http://supercollider.sourceforge.net/)
* [Processing](http://processing.org/)
* [processing-sc library](http://www.erase.net/projects/processing-sc/)

###Commands

  synthDef => pattern ! length

* synthDef = name of synthDef loaded into SuperCollider server
* pattern consists of any text or combination of letters, note that space means no sound
* length is length of sample in seconds * 10

###Shortcuts

* 'a'..'z' = typing input
* UP / DOWN keys changing tempo
* '`' or '~' turning on listen mode
* DELETE removing last pattern

###TODO

* better navigation
* another mapping of tones
* volume controls per pattern, muting, pitch shifting
