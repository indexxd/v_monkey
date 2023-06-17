import readline {read_line}

fn start_console() ! {
	for true {
		input := read_line(">> ")!
		
		if input.len == 0 {
			return
		}
		
		println(input)
		mut lexer := new_lexer(input)
		
		for token := lexer.next_token(); token.token_type != _eof; token = lexer.next_token() {
			println(token)
		}
	}
}
