package main

import (
	"fmt"
	"gopkg.in/yaml.v2"
	"io/ioutil"
	"log"
)

type EksctlSchema struct {
	ApiVersion        string   `yaml:"apiVersion"`
	Kind              string   `yaml:"kind"`
	AvailabilityZones []string `yaml:"availabilityZones"`
	Metadata          struct {
		Name    string `yaml:"name"`
		Version string `yaml:"version"`
		Region  string `yaml:"region"`
		Tags    struct {
			App  string `yaml:"app"`
			Env  string `yaml:"env"`
			Type string `yaml:"type"`
		} `yaml:"tags"`
	} `yaml:"metadata"`
	ManagedNodeGroups []struct {
		Name            string `yaml:"name"`
		DesiredCapacity int    `yaml:"desiredCapacity"`
		InstanceType    string `yaml:"instanceType"`
		Ssh             struct {
			EnableSsm bool `yaml:"enableSsm"`
		} `yaml:"ssh"`
	} `yaml:"managedNodeGroups"`
	Iam struct {
		WithOIDC bool `yaml:"withOIDC"`
	} `yaml:"iam"`
	SecretsEncryption struct {
		KeyARN string `yaml:"keyARN"`
	} `yaml:"secretsEncryption"`
}

func main() {
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
