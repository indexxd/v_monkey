module main

struct TokenAssert {
	token_type TokenType
	literal string
	position int [required]
}

fn test_next_token() {
	input := "let five = 5;
let ten = 10;

let add = fn(x, y) {
	x + y;
}

let result = add(five, ten);
!-/*5;
5 < 10 > 5;

if (5 < 10) {
	return true;
} else {
	return false;
}

10 == 10;
10 != 9;
"


	mut i := 0
	expects := [ 
		TokenAssert{_let, "let", i++},
		TokenAssert{_ident, "five", i++},
		TokenAssert{_assign, "=", i++},
		TokenAssert{_integer, "5", i++},
		TokenAssert{_semicolon, ";", i++},
		TokenAssert{_let, "let", i++},
		TokenAssert{_ident, "ten", i++},
		TokenAssert{_assign, "=", i++},
		TokenAssert{_integer, "10", i++},
		TokenAssert{_semicolon, ";", i++},
		TokenAssert{_let, "let", i++},
		TokenAssert{_ident, "add", i++},
		TokenAssert{_assign, "=", i++},
		TokenAssert{_function, "fn", i++},
		TokenAssert{_lparen, "(", i++},
		TokenAssert{_ident, "x", i++},
		TokenAssert{_comma, ",", i++},
		TokenAssert{_ident, "y", i++},
		TokenAssert{_rparen, ")", i++},
		TokenAssert{_lbrace, "{", i++},
		TokenAssert{_ident, "x", i++},
		TokenAssert{_plus, "+", i++},
		TokenAssert{_ident, "y", i++},
		TokenAssert{_semicolon, ";", i++},
		TokenAssert{_rbrace, "}", i++},
		TokenAssert{_let, "let", i++},
		TokenAssert{_ident, "result", i++},
		TokenAssert{_assign, "=", i++},
		TokenAssert{_ident, "add", i++},
		TokenAssert{_lparen, "(", i++},
		TokenAssert{_ident, "five", i++},
		TokenAssert{_comma, ",", i++},
		TokenAssert{_ident, "ten", i++},
		TokenAssert{_rparen, ")", i++},
		TokenAssert{_semicolon, ";", i++},
		TokenAssert{_bang, "!", i++},
		TokenAssert{_minus, "-", i++},
		TokenAssert{_slash, "/", i++},
		TokenAssert{_asterisk, "*", i++},
		TokenAssert{_integer, "5", i++},
		TokenAssert{_semicolon, ";", i++},
		TokenAssert{_integer, "5", i++},
		TokenAssert{_lt, "<", i++},
		TokenAssert{_integer, "10", i++},
		TokenAssert{_gt, ">", i++},
		TokenAssert{_integer, "5", i++},
		TokenAssert{_semicolon, ";", i++},
		TokenAssert{_if, "if", i++},
		TokenAssert{_lparen, "(", i++},
		TokenAssert{_integer, "5", i++},
		TokenAssert{_lt, "<", i++},
		TokenAssert{_integer, "10", i++},
		TokenAssert{_rparen, ")", i++},
		TokenAssert{_lbrace, "{", i++},
		TokenAssert{_return, "return", i++},
		TokenAssert{_true, "true", i++},
		TokenAssert{_semicolon, ";", i++},
		TokenAssert{_rbrace, "}", i++},
		TokenAssert{_else, "else", i++},
		TokenAssert{_lbrace, "{", i++},
		TokenAssert{_return, "return", i++},
		TokenAssert{_false, "false", i++},
		TokenAssert{_semicolon, ";", i++},
		TokenAssert{_rbrace, "}", i++},
		TokenAssert{_integer, "10", i++},
		TokenAssert{_eq, "==", i++},
		TokenAssert{_integer, "10", i++},
		TokenAssert{_semicolon, ";", i++},
		TokenAssert{_integer, "10", i++},
		TokenAssert{_not_eq, "!=", i++},
		TokenAssert{_integer, "9", i++},
		TokenAssert{_semicolon, ";", i++},
		TokenAssert{_eof, "", i++},
	]
	
	mut lexer := new_lexer(input)

	mut ii := 0
	for expect in expects {
		token := lexer.next_token()
		assert expect == TokenAssert{token.token_type, token.literal, ii++}
	}

}