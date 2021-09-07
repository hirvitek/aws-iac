package main

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

