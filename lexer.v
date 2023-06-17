
struct Lexer {
pub:
	input string [required]
pub mut:
	ch            byte
	position      int
	read_position int
}

pub fn new_lexer(input string) Lexer {
	mut lexer := Lexer{
		input: input
	}

	lexer.read_char()
	return lexer
}

fn (mut lexer Lexer) next_token() Token {
	mut token := Token{}

	lexer.skip_whitespace()

	match lexer.ch {
		`=` {
			match lexer.peek_next() {
				`=` {
					lexer.read_char()
					token = Token{_eq, '=='}
				}
				else {
					token = Token{_assign, lexer.ch.ascii_str()}
				}
			}
		}
		`!` {
			match lexer.peek_next() {
				`=` {
					lexer.read_char()
					token = Token{_not_eq, '!='}
				}
				else {
					token = Token{_bang, lexer.ch.ascii_str()}
				}
			}
		}
		`;` {
			token = Token{_semicolon, lexer.ch.ascii_str()}
		}
		`(` {
			token = Token{_lparen, lexer.ch.ascii_str()}
		}
		`)` {
			token = Token{_rparen, lexer.ch.ascii_str()}
		}
		`,` {
			token = Token{_comma, lexer.ch.ascii_str()}
		}
		`+` {
			token = Token{_plus, lexer.ch.ascii_str()}
		}
		`{` {
			token = Token{_lbrace, lexer.ch.ascii_str()}
		}
		`}` {
			token = Token{_rbrace, lexer.ch.ascii_str()}
		}
		`-` {
			token = Token{_minus, lexer.ch.ascii_str()}
		}
		`/` {
			token = Token{_slash, lexer.ch.ascii_str()}
		}
		`*` {
			token = Token{_asterisk, lexer.ch.ascii_str()}
		}
		`<` {
			token = Token{_lt, lexer.ch.ascii_str()}
		}
		`>` {
			token = Token{_gt, lexer.ch.ascii_str()}
		}
		0 {
			token = Token{_eof, ''}
		}
		else {
			if is_letter(lexer.ch) {
				token.literal = lexer.read_identifier()
				token.token_type = get_token_type_for_ident(token.literal)
				return token
			} else if is_digit(lexer.ch) {
				token.literal = lexer.read_number()
				token.token_type = _integer
				return token
			}

			token = Token{_illegal, lexer.ch.ascii_str()}
		}
	}

	lexer.read_char()

	return token
}

pub fn (mut lexer Lexer) read_number() string {
	mut chars := []byte{}

	for is_digit(lexer.ch) {
		chars << lexer.ch

		lexer.read_char()
	}

	return chars.bytestr()
}

fn (lexer Lexer) peek_next() byte {
	return lexer.input[lexer.read_position]
}

fn is_digit(ch byte) bool {
	return ch >= `0` && ch <= `9`
}

fn (mut lexer Lexer) skip_whitespace() {
	for lexer.ch == ` ` || lexer.ch == `\t` || lexer.ch == `\n` || lexer.ch == `\r` {
		lexer.read_char()
	}
}

fn (mut lexer Lexer) read_identifier() string {
	mut chars := []byte{}

	for is_letter(lexer.ch) {
		chars << lexer.ch

		lexer.read_char()
	}

	return chars.bytestr()
}

fn (mut lexer Lexer) read_char() {
	if lexer.read_position >= lexer.input.len {
		lexer.ch = 0 // EOF
	} else {
		lexer.ch = lexer.input[lexer.read_position]
	}

	lexer.position = lexer.read_position
	lexer.read_position++
}

fn is_letter(ch byte) bool {
	return (`a` <= ch && ch <= `z`) || (`A` <= ch && ch <= `Z`) || ch == `_`
}
