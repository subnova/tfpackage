package test

import (
	"github.com/subnova/tfpackage/infra/shared"
	"path"
	"testing"
)
import "github.com/gruntwork-io/terratest/modules/terraform"
import "github.com/stretchr/testify/assert"

func TestInfraStack(t *testing.T) {
	stackDir, err := shared.ExtractStackPackage("infra/src/src.tar")
	if err != nil {
		t.Fatal(err)
	}

	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir:    stackDir,
		TerraformBinary: path.Join(stackDir, "terraform"),

		Vars: map[string]interface{}{
			"env": shared.GenerateStringWithCharset(5, shared.LowerAlphaNum),
		},

		EnvVars: map[string]string{
			"AZURE_LOGGING_ENABLE_LOG_FILE": "false",
		},

		NoColor: true,
	})
	defer terraform.Destroy(t, terraformOptions)

	terraform.InitAndApply(t, terraformOptions)

	output := terraform.Output(t, terraformOptions, "acr_login_server")
	assert.NotEmpty(t, output)
}

