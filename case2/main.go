package main

import (
	"bufio"
	"fmt"
	"math/rand"
	"os"
	"strconv"
	"strings"
	"time"
)

func main() {
	isPlaying := true
	playerCount := 0
	diceCount := 0
	gameStep := 0
	rand.Seed(time.Now().UnixNano())

	for isPlaying {
		if gameStep == 0 {
			gameStep = 1
			fmt.Print("Masukkan jumlah pemain : ")
			_, err := fmt.Scanln(&playerCount)
			if err != nil {
				fmt.Println("Mohon hanya masukkan angka!")
				gameStep = 0
				continue
			}
			fmt.Printf("Jumlah pemain : %v ... \n\n", playerCount)
		}

		if gameStep == 1 {
			gameStep = 2
			fmt.Print("Masukkan jumlah dadu : ")
			_, err := fmt.Scanln(&diceCount)
			if err != nil {
				fmt.Println("Mohon hanya masukkan angka!")
				gameStep = 1
				continue
			}
			fmt.Printf("Jumlah dadu : %v ... \n\n", diceCount)
		}

		if gameStep == 2 {
			gameStep = 3
			fmt.Println("===++ Permainan akan dimulai ++===")
			gameCycle(diceCount, playerCount)
		}

	}
}

func gameCycle(diceCount int, playerCount int) {
	var playerPoint []int
	var playerDice []int
	var additionalDice []int

	fmt.Printf("<> Game Info <> \n * Jumlah pemain : %v \n * Jumlah dadu : %v \n=== ++ **<<>> <<>> <<>> <<>>** ++ ===\n", playerCount, diceCount)
	for playerNumber := 1; playerNumber <= playerCount; playerNumber++ {
		playerDice = append(playerDice, diceCount)
		playerPoint = append(playerPoint, 0)
		additionalDice = append(additionalDice, 0)
		fmt.Printf("Pemain-%v | Jumlah Dadu : %v | Poin : %v \n", playerNumber, playerDice[playerNumber-1], playerPoint[playerNumber-1])
	}
	fmt.Printf("=== ++ **<<>> <<>> <<>> <<>>** ++ ===\n\n")

	for round := 0; round > -1; round++ {
		currentWinner := 0
		currentHighestPoint := 0
		playerLeft := playerCount
		fmt.Printf("=== ++ **<<>> ROUND %v <<>>** ++ ===\n", round+1)
		fmt.Print("Lanjutkan permainan ? (*input*) Y. Yes N. No\nChoice : ")
		reader := bufio.NewReader(os.Stdin)
		choice, _ := reader.ReadString('\n')
		choice = strings.TrimSuffix(choice, "\r\n")

		if choice == "Y" {
			fmt.Printf("== ROUND %v STARTED ==\n", round+1)
			for playerNumber := 1; playerNumber <= playerCount; playerNumber++ {
				if playerDice[playerNumber-1] > 0 {
					allDice := ""
					fmt.Printf("Player-%v Rolls and got : \n", playerNumber)
					for diceRoll := 0; diceRoll < playerDice[playerNumber-1]; diceRoll++ {
						diceNumber := (rand.Intn(6) + 1)
						if allDice == "" {
							allDice = strconv.Itoa(diceNumber)
						} else {
							allDice = allDice + ", " + strconv.Itoa(diceNumber)
						}
						if diceNumber == 6 {
							additionalDice[playerNumber-1]--
							playerPoint[playerNumber-1]++
						}
						if diceNumber == 1 {
							plusDice := 1
							additionalDice[playerNumber-1] = additionalDice[playerNumber-1] - 1
							for a := playerNumber; a < playerNumber; a++ {
								if playerDice[a] > 0 {
									additionalDice[a] = additionalDice[a] + plusDice
									plusDice = 0
								}
							}
							for b := 0; b < playerNumber-1; b++ {
								if playerDice[b] > 0 {
									additionalDice[b] = additionalDice[b] + plusDice
									plusDice = 0
								}
							}
						}
					}
					fmt.Println(allDice)
				}
				continue
			}
			playerLeft = playerCount
			fmt.Print("------------- SCORE BOARD ----------------\n")
			for playerNumber := 1; playerNumber <= playerCount; playerNumber++ {
				playerDice[playerNumber-1] = playerDice[playerNumber-1] + additionalDice[playerNumber-1]
				additionalDice[playerNumber-1] = 0
				if currentHighestPoint < playerPoint[playerNumber-1] {
					currentWinner = playerNumber
					currentHighestPoint = playerPoint[playerNumber-1]
				}
				fmt.Printf("Pemain-%v | Jumlah Dadu : %v | Poin : %v \n", playerNumber, playerDice[playerNumber-1], playerPoint[playerNumber-1])
				if playerDice[playerNumber-1] == 0 {
					playerLeft--
				}
			}

			if playerLeft <= 1 {
				fmt.Printf("Pemenang : Player-%v | Point : %v \n", currentWinner, currentHighestPoint)
				return
			} else if currentWinner > 0 {
				fmt.Printf("Point tertinggi %v oleh Pemain-%v\n", currentHighestPoint, currentWinner)
			}
			fmt.Print("------------------------------------------\n")
		}

		if choice == "N" {
			fmt.Printf("<> Game Info <> \n * Jumlah pemain : %v \n * Jumlah dadu : %v \n=== ++ **<<>> <<>> <<>> <<>>** ++ ===\n", playerCount, diceCount)
			for playerNumber := 1; playerNumber <= playerCount; playerNumber++ {
				fmt.Printf("Pemain-%v | Jumlah Dadu : %v | Poin : %v \n", playerNumber, playerDice[playerNumber-1], playerPoint[playerNumber-1])
			}
			fmt.Printf("=== ++ **<<>> <<>> <<>> <<>>** ++ ===\n\n")

			if currentWinner > 0 {
				fmt.Printf(" Highest Point : %v by Player-%v\n", currentHighestPoint, currentWinner)
			}
			fmt.Printf("=== ++ **<<>> GAME ENDED <<>>** ++ ===\n\n")
			break
		}
	}
}
