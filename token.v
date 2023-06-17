pub type TokenType = string

pub const token_map = {
	'fn':     _function
	'let':    _let
	'true':   _true
	'false':  _false
	'if':     _if
	'else':   _else
	'return': _return
}

pub struct Token {
pub mut:
	token_type TokenType
	literal    string
}

pub fn get_token_type_for_ident(ident string) TokenType {
	return token_map[ident] or { _ident }
}

pub fn new_token(token_type TokenType, ch string) Token {
	return Token{
		token_type: token_type
		literal: ch.str()
	}
}

pub const _illegal = 'ILLEGAL'

pub const _eof = 'EOF'

pub const _ident = 'IDENT'

pub const _integer = 'INTEGER'

pub const _assign = '='

pub const _plus = '+'

pub const _comma = ','

pub const _semicolon = ';'

pub const _lparen = '('

pub const _rparen = ')'

pub const _lbrace = '{'

pub const _rbrace = '}'

pub const _function = 'FUNCTION'

pub const _let = 'LET'

pub const _true = 'TRUE'

pub const _false = 'FALSE'

pub const _return = 'RETURN'

pub const _if = 'IF'

pub const _else = 'ELSE'

pub const _minus = '-'

pub const _bang = '!'

pub const _asterisk = '*'

pub const _slash = '/'

pub const _not_eq = '!='

pub const _eq = '=='

pub const _lt = '<'

pub const _gt = '>'
