# -*- coding: iso-8859-1 -*-
"""
        MoinMoin - LSL (Linden Scripting Language) Parser version 0.1

    @copyright: 2006 by Thilo pfennig <tpfennig@gmail.com>
    based on Java parser by Taesu Pyo <bigflood@hitel.net>
    @license: GNU GPL, see COPYING for details.

	%SHILL_UPDATE_NOTICE%

	Add the css of your choice:
	div.codearea span.ResWord2 { color: #0080ff; font-weight: bold; }
    div.codearea span.Special  { color: #0000ff; }

"""

from MoinMoin.util.ParserBase import ParserBase

Dependencies = []

class Parser(ParserBase):

    parsername = "ColorizedLsl"
    extensions = ['.lsl']
    Dependencies = []

    def setupRules(self):
        ParserBase.setupRules(self)

        self.addRulePair("Comment","/[*]","[*]/")
        self.addRule("Comment","//.*$")
        self.addRulePair("String",'"',r'$|[^\\](\\\\)*"')
        self.addRule("Char",r"'\\.'|'[^\\]'")
        self.addRule("Number",r"[0-9](\.[0-9]*)?(eE[+-][0-9])?[flFLdD]?|0[xX][0-9a-fA-F]+[ll]?")
        self.addRule("ID","[a-zA-Z_][0-9a-zA-Z_]*")
        self.addRule("SPChar",r"[~!%^&*()+=|\[\]:;,.<>/?{}-]")

        reserved_words = [
			'default',
			'do',
			'else',
			'for',
			'if',
			'jump',
			'return',
			'state',
			'while',
			'float',
			'integer',
			'key',
			'list',
			'rotation',
			'string',
			'vector'
		]
        self.addReserved(reserved_words)

		event_words = [
START:events
			'%name%',
END:events
			'last-event-with-no-comma'
		]
		self.addWords(event_words,'ResWord2')

        constant_words = [			
START:constants
			'%name%',
END:constants
			'last-constant-with-no-comma'
			]
        self.addConstant(constant_words)

		function_words = [
START:functions
			'%name%',
END:functions
			'last-function-with-no-comma'	
		]
        self.addWords(function_words,'Special')
