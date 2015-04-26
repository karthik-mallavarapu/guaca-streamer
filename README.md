# guaca-streamer
Guacamole client application to interact with live RDP/VNC sessions.
## Description
### Guacamole 
[Guacamole](http://guac-dev.org/) is a clientless HTML5 remote desktop gateway supporting standard remote desktop protocols like RDP and VNC. 
#### Architecture
Guacamole client applications interact with remote desktops via the guacamole proxy daemon (guacd). Guacd dynamically loads support for remote desktop servers and connects them to remote desktop servers based on the instructions received from the client. The following figure presents the high level architecture of a guacamole web client. 
![alt text](http://guac-dev.org/doc/gug/images/guac-arch.png "Architecture") [1]
#### Protocol
Guacamole clients interact with guacd using the guacamole protocol, a protocol for display rendering and event transport [2].
Each instruction is a comma-delimited list followed by a terminating semicolon, where the first element of the list is the instruction opcode, and all following elements are the arguments for that instruction:

    `OPCODE,ARG1,ARG2,ARG3,...;`
Each element of the list has a positive decimal integer length prefix separated by the value of the element by a period. This length denotes the number of Unicode characters in the value of the element, which is encoded in UTF-8 [3]:

    `LENGTH.VALUE`
A valid client instruction for informing the server about the remote desktop protocol is of the following form:

    `6.select,3.vnc;`
## Requirements and Installation
  * ruby 2.1.1
  * guacd (Guacamole proxy daemon)
      
      [Installation] (http://guac-dev.org/doc/gug/installing-guacamole.html)
  * imagemagick (image processing library)
      
      `brew install imagemagick`
  * gosu (2D graphics and game development library)
  
## Instructions
* Setup guacd on a remote server 
* Clone (guacamole client) [https://github.com/karthik-mallavarapu/guaca-streamer]
* `bundle install`
* `bundle exec ruby guac_runner.rb`


## Sources
1. http://guac-dev.org/doc/gug/images/guac-arch.png
2. http://guac-dev.org/doc/gug/guacamole-architecture.html
3. http://guac-dev.org/doc/gug/guacamole-protocol.html
