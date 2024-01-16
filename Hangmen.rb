def display_hangman(incorrect_guesses)
    hangman_graphics = [
        
        "\n        _______\n        |/    |\n        |     x\n        |    /|\\\n        |    / \\\n        |\n      __|_______\n      ",
      "\n      _______\n      |/    |\n      |\n      |\n      |\n      |\n    __|_______\n    ",
      "\n      _______\n      |/    |\n      |     O\n      |\n      |\n      |\n    __|_______\n    ",
      "\n      _______\n      |/    |\n      |     O\n      |     |\n      |\n      |\n    __|_______\n    ",
      "\n      _______\n      |/    |\n      |     O\n      |    |\\\n      |\n      |\n    __|_______\n    ",
      "\n      _______\n      |/    |\n      |     O\n      |    /|\\\n      |\n      |\n    __|_______\n    ",
      "\n      _______\n      |/    |\n      |     O\n      |    /|\\\n      |    /\n      |\n    __|_______\n    ",
      "\n      _______\n      |/    |\n      |     O\n      |    /|\\\n      |    / \\\n      |\n    __|_______\n    ",
      "\n        _______\n        |/    |\n        |     0\n        |    /|\\\n        |    / \\\n        |\n      __|_______\n      ",
    ]
    puts hangman_graphics[incorrect_guesses]
end



def random_word

    file = File.open("google-10000-english-no-swears.txt")
    file_data = file.readlines.map(&:chomp)
    choice = nil

    loop do

    choice = rand(0...file_data.length)
        break if file_data[choice].length.between?(5,12)
    end

    file_data[choice]
end

def count_word(string) 
    hash = string.split("").reduce(Hash.new(0)) do |hash, word|
      hash[word] += 1
      hash
    end
end
def crypted_word(string)

    word=""
    string.split("").each{|_char| word += "_" }
    word
end

def update_magic_word(magic_word,word,char)

    word.split("").each_with_index do |value,index| 
        if magic_word[index] == "_" && value == char then
            magic_word[index]= char
            return true
        end
    end

end


def gussing
    char=nil
    word = "amira"
    chance=7
    hash = count_word(word)
    magic_word = crypted_word(word)
    display_hangman(7)
    loop do
        puts "give char :"
        char =gets.chomp
        if hash.fetch(char,"none") == "none" then
            chance-=1
            puts "wrong your chance are #{chance}"
            puts "magic_word :#{magic_word}"
            display_hangman(chance)
        elsif magic_word.count(char) < hash[char]
            update_magic_word(magic_word,word,char)
            puts "magic_word :#{magic_word}"
        end
        break if (magic_word ==word) or chance==0
    end
    if chance ==0 then
        puts "you lose the word is #{word}"
        display_hangman(0)
    else
        puts "you win"
    end
end
gussing


    

