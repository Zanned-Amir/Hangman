require "json"
def display_hangman(incorrect_guesses)
    hangman_graphics = [
        
        "\n        _______\n        |/    |\n        |     x\n        |    /|\\\n        |    / \\\n        |\n      __|_______\n      ",
      "\n      _______\n      |/    |\n      |\n      |\n      |\n      |\n    __|_______\n    ",
      "\n      _______\n      |/    |\n      |     O\n      |\n      |\n      |\n    __|_______\n    ",
      "\n      _______\n      |/    |\n      |     O\n      |     |\n      |\n      |\n    __|_______\n    ",
      "\n      _______\n      |/    |\n      |     O\n      |    /|  \n      |\n      |\n    __|_______\n    ",
      "\n      _______\n      |/    |\n      |     O\n      |     |\\\n      |\n      |\n    __|_______\n    ",
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
      break if file_data[choice].length.between?(5, 12)
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
    puts string
    word = "_" * string.length
    word
  end
  
  def update_magic_word(magic_word, word, char)
    word.split("").each_with_index do |value, index|
      if magic_word[index] == "_" && value == char
        magic_word[index] = char
        return true
      end
    end
  end
  
  class Game
    DEFAULT_CHANCE = 7
    DEFAULT_WORD = random_word
    attr_accessor :save, :restart
  
    def initialize(save)
      @save = save
      puts "Do you want to restart (1) / choose save game (2)"
      @choice = gets.chomp
      @restart = @choice.to_s.include?("1")
      @save_instance = Save.new 
    end
  
    def start
      char = nil
  
      if @restart == true
        word = DEFAULT_WORD
        chance = DEFAULT_CHANCE
        number = 7
        magic_word = crypted_word(word)
        hash = count_word(word)
        display_hangman(number)
        puts "Game begin"
      else
        json = (JSON.load File.read(self.save)).to_json
        @save_instance.from_json(json)
        puts @save_instance.save_data
        @save_instance.display_all_saves
        puts "Choose your save file {index 0..}:"
        index = gets.chomp
        save = @save_instance.choose_save(index)
        magic_word = save["magic_word"]
        word = save["word"]
        chance = save["chance"]
        hash = count_word(word)
        display_hangman(chance)
        puts "Save game #{index} begin"
      end
      leave = nil
      loop do
        puts "Give char:"
        char = gets.chomp
        if hash.fetch(char, "none") == "none"
          chance -= 1
          puts "Wrong! Your chance is #{chance}"
          puts "Magic_word: #{magic_word}"
          display_hangman(chance)
        elsif magic_word.count(char) < hash[char]
          update_magic_word(magic_word, word, char)
          puts "Magic_word: #{magic_word}"
        end
        puts "wanna save and leave y/n:"
        leave = gets.chomp.include?("y")
        if leave
          @save_instance.add_to_save(word, chance, magic_word)
          string_json = @save_instance.save_data.to_json
          File.write(@save, string_json, mode: 'w')
        end
  
        break if (magic_word == word) || chance == 0 || leave == true
      end
  
      if chance == 0
        puts "You lose! The word is #{word}"
        display_hangman(0)
      elsif leave == true
        puts "Data saved"
      else
        puts "You win!"
      end
    end
  end
  
  class Save
    attr_accessor :save_data
  
    def initialize
      @save_data = { save: [] }
    end
  
    def add_to_save(word, chance, magic_word)
      if File.exist?('save.json')
        load_existing_data
      else
        @save_data = { save: [] }
      end
  
      new_data = {
        word: word,
        chance: chance,
        magic_word: magic_word
      }
  
      @save_data[:save] << new_data
      save_to_file
    end
  
    def load_existing_data
      existing_data = JSON.parse(File.read('save.json'))
      @save_data[:save] = existing_data['save'] if existing_data['save']
    end
  
    def save_to_file
      File.write('save.json', @save_data.to_json, mode: 'w')
    end
  
    def update_save(word, chance, magic_word)
      new_data = {
        word: word,
        chance: chance,
        magic_word: magic_word
      }
      @save_data[:save][-1] = new_data
    end
  
    def from_json(json_string)
      parsed_data = JSON.parse(json_string)
      @save_data[:save] = parsed_data['save'] if parsed_data['save']
    end
  
    def display_all_saves
      return unless @save_data[:save]
  
      @save_data[:save].each_with_index do |save, index|
        puts "Index: #{index}, Chance: #{save['chance']}, Magic Word: #{save['magic_word']}"
      end
    end
  
    def choose_save(index)
      chosen_save = @save_data[:save][index.to_i]
      puts "Chosen Save: Chance: #{chosen_save['chance']}, Magic Word: #{chosen_save['magic_word']}"
      chosen_save
    end
  end
  
  game = Game.new("save.json")
  game.start

