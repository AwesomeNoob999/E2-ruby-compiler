#TOKENS = [ "=", "+", "-", "end", ";", "<", ">", "?", "/", '"', "modof", "_", "{", "}", "or", "[", "]", "method", "fun", "==", "def", "assemble", "(", ")", ":", "initialize"]

file_name = ARGV[0]
file = File.read(file_name)

class Compile
    
    def tokenize(file)
	file = file
	tokens = []
	count = 0
	operators = ["`","~","!","@","$","%","^","&","*","(",")","-","+","=","[","]","{","}","|",";","<",">","/","?"]
	numbers = ["1","2","3","4","5","6","7","8","9","0"]
	letter = [">","a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","x","y","z","_","A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z"]
	while file.length > count
	    char = file[count]
	    if char == "#"
		value = ""
		char = file[count += 1]
		while char != "#"
		    value << char
		    char = file[count += 1]
		end
	    char = file[count+=1]
	    tokens << {:compiler_settings => value}
	    end
	    
	    
	    if letter.include?(char)
		value = ""
		while char != " " and char != ":" and char != "\n"
		    value << char
		    char = file[count += 1]
		end
		if char != ":" 
		    tokens << {:word_literal => value}
		elsif char == ":"
		    tokens << {:variable_name => value} 
		    char = file[count += 1]
		end
	    end
	    
	    if char == " " or char == "\n" 
		char = file[count += 1]
	    end
	    
	    if operators.include?(char)
		value = ""
		while char != " " and char != "\n" 
		    value << char
		    char = file[count += 1]
		end
		tokens << {:operator_literal => value}
		char = file[count += 1]
	    end
	    
	    
	    if numbers.include?(char)
		value = ""
		    while char != " " and char != "\n"
		    value << char
		    char = file[count += 1]
		end
		tokens << {:number_literal => value}
	    end
	end
	return tokens
    end
    
    def compiler_tokenizer(tokens)
	compiler_tokens = []
	index = 0
	for token in tokens
	    if token.keys[0] == :compiler_settings
		value = ""
		string=token.values[0]
		(string.length).times do |pos|
		    char = string[pos]
		    value << char if char != " " and char != "\n"
		    if char == " " or char == "\n"
			compiler_tokens << value if value != ""
			value = ""
		    end
		end
	    end
	end
	return compiler_tokens
    end
    
    def parse_tokens(tokens)
	ast = {}
	variable = {}
	count = 0
	count2 = 0
	for token in tokens
	    if token.keys[0] == :variable_name
		variable[token.values[0]] ={} 
	    elsif token.keys[0] == :word_literal and previous_token.keys[0] == :variable_name
		variable[previous_token.values(0)][token.values[0]] => nil
	    elsif token.values[0] == "=" 
		variable[previous_token.values[0]].key?.
	    end
	    
	    previous_token = token
	end
    end
    
    def parse_comp_tokens(comp_tokens)
    end
    
end

compiler = Compile.new
tokens = compiler.tokenize(file)
comp_tokens = compiler.compiler_tokenizer(tokens)
compiler.parse_tokens(tokens)
