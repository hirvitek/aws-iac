package main

import (
	"fmt"
	"github.com/joho/godotenv"
	"gopkg.in/yaml.v2"
	"io/ioutil"
	"log"
	"os"
)

func main() {
	if err := godotenv.Load("../.env"); err != nil {
		log.Fatal(err)
	}

	certificatesArn := os.Getenv("AWS_ACM_CERTIFICATES_ARN")
	fmt.Println(certificatesArn)

	file, err := ioutil.ReadFile("../cluster.yaml")
	if err != nil {
		log.Fatal(err)
	}

	t := EksctlSchema{}

	if err := yaml.Unmarshal(file, &t); err != nil {
		return
	}

	fmt.Printf("%+v\n", t)
}
