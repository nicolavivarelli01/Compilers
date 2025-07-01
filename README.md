# Compilers
## Changes Done:
### parser.cup
Minimal correction in grammar print_list function in parser.cup that handles the correct order 
(during the exam i read a print_list true or a print_list false but it had to be one followed by another), added 2 markers to match the spec

---
### scanner.jflex
Binary number adjustment in scanner, also removed whitespaces that caused issues when matching tokens, 
minor adjustments in scanner for hour adding "\:" in front
