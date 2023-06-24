#TOKENS = [ "=", "+", "-", "end", ";", "<", ">", "?", "/", '"', "modof", "_", "{", "}", "or", "[", "]", "method", "fun", "==", "def", "assemble", "(", ")", ":", "initialize"]

file_name = ARGV[0]
file = File.read(file_name)

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

tokens = tokenize(file)
p tokens

