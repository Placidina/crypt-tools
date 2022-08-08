package main

import (
	"flag"
	"log"
	"os"

	"golang.org/x/crypto/bcrypt"
)

var (
	password = flag.String("password", "", "The password to create hash")
	cost     = flag.Int("cost", 10, "Argument is optional and will default to 10 if unspecifie")
)

func main() {
	flag.Parse()

	if *password == "" {
		log.Printf("Password argument is required")
		os.Exit(1)
	}

	out, err := bcrypt.GenerateFromPassword([]byte(*password), *cost)
	if err != nil {
		log.Printf("Error occured generating password: %v", err)
		os.Exit(10)
	}

	log.Printf("Password Hash: %s", string(out))
}
