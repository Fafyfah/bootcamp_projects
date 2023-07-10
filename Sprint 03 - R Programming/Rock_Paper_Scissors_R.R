library(dplyr)

writeLines(c("  Welcome to Rock-Paper-Scissors Game!",
             "  >>>Instruction<<<",
             "  In this game you will play against the bot.",
             "1.Type 'rock', 'paper', or 'scissors', then press Enter to choose your option.",
             "2.The bot will randomly choose their option, and the result will be shown.",
             "3.To quit the game, type 'q' and press Enter.",
             "*The game will keep track of your score from each round. You will see a summary of your final score after you quit."
)
)

## initial score
player_score <- 0
bot_score <- 0
tie_score <- 0

## List of options
options <- c("rock","paper","scissors","q")

# Game loop
while(TRUE){
  player_choice <- tolower(readline("Enter rock, paper, or scissors (enter q to quite) : "))
  
  # Check player's choice
  if (player_choice == "q"){
    print("Final Score")
    cat("From", player_score + bot_score + tie_score,"round")
    cat("\nPlayer score : ", player_score)
    cat("\nBot score : ", bot_score)
    cat("\nTie times:", tie_score)
    break
  }
  else if (!(player_choice %in% options)){
    print("Invalid choice. Please enter rock, paper, or scissors.")
    next
  }
  
  # Random bot's choice
  bot_choice <- sample(options, 1)
  print(bot_choice)
  
  # Determine the winner
  if (player_choice == bot_choice) {
    print("It's a tie!")
    tie_score <- tie_score+1
  } 
  else if ((player_choice == "rock" & bot_choice == "scissors") || (bot_choice == "paper" & bot_choice == "rock") || (player_choice == "scissors" & bot_choice == "paper")) {
    print("You win!")
    player_score <- player_score + 1
  } 
  else {
    print("You lose.")
    bot_score <- bot_score + 1
  }
}