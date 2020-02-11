old_sync = $stdout.sync
$stdout.sync = true

restart = "y"

while restart == "y"
ended = 0 # Checks if the game has ended
counter = 0 # Used to go through the letters in the secret word
right = false # Checks if the guess entered was correct
lives = 10

word = ["tree", "banana", "flamingo", "indestructable", "rhythm", "remember", "toucan", "popular", "python", "cauliflower", "gripped", "purple"] # Word List
r_word = word.sample # r_word = Random Word

h_word = r_word.chars.to_a # h_word = Hangman Word

l_word = h_word.length # l_word = Length of Word

g_word = Array.new # g_word = Guessed Word

display = Array.new # Displayed Guess

guesses = Array.new # Guess List

  while l_word != 0 # Inserts items into the g_word and display array
    g_word << "_"
    display << "_"
    display << " " # Allows the display to be easy to count the number of letters
    l_word -= 1
  end

  puts display.join

  while ended == 0

    puts "Guess a letter. Type 'guess' to see the list of guesses:"
    guess = gets.chomp.to_s
    if guess == "guess"
      puts "You have already guessed the following: #{guesses}"
      puts display.join
    else
      while h_word[counter] != nil
        if h_word[counter] == guess
          display.delete_at(counter*2) # Deletes an underscore at the location of the letter in the secret word
          display.insert(counter*2, guess) # Inserts the correct letter at the actual location in the secret word
          g_word.delete_at(counter) # Deletes an underscore at the location of the letter in the secret word
          g_word.insert(counter, guess) # Inserts the correct letter at the actual location in the secret word
          counter += 1
          right = true # The guessed letter is in the secret word
        else
          counter += 1
        end
      end

      guesses << guess
      counter = 0
      puts display.join

      if right == false # If the guessed letter is not in the secret word
        lives -= 1
        puts "#{lives} LIVES REMAINING"
      end

      if lives == 0 # If the player lost all their lives
        puts "You failed. The word was #{r_word}."
        ended += 1 # Game has ended
      end

      if g_word.join == r_word # If the player has guessed the entire word
        puts "You win!"
        ended += 1 # Game has ended
      end

      if ended > 0 # If game has ended
        puts "Play again? y/n"
        restart = gets.chomp.to_s
      end

      if restart == "n"
        break
      end

      right = false

    end
  end
end
